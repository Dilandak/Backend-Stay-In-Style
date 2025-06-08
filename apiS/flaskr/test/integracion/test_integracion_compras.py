import unittest
import json
import random
import sys
from os.path import dirname, abspath
from faker import Faker
from datetime import datetime
from werkzeug.security import generate_password_hash
from flask_jwt_extended import create_access_token

# Configurar path para imports
sys.path.insert(0, dirname(dirname(dirname(abspath(__file__)))))

from flaskr import create_app, db
from flaskr.modelos import (
    Usuario, Producto, Rol, MetodoPago, Talla, 
    Inventario, Compra, Carrito, CarritoProducto,
    Categoria, Genero
)

class TestIntegracionCompras(unittest.TestCase):
    def setUp(self):
        self.fake = Faker('es_MX')
        self.app = create_app('testing')
        self.client = self.app.test_client()
        
        # Configurar contexto de aplicación
        self.app_context = self.app.app_context()
        self.app_context.push()
        
        # Crear estructura de base de datos
        db.create_all()
        
        # Crear roles
        self.rol_cliente = Rol(nombre="Cliente")
        db.session.add(self.rol_cliente)
        
        # Crear método de pago
        self.metodo_pago = MetodoPago(
            tipo=random.choice(["Tarjeta", "Transferencia", "Efectivo"]),
            detalle=self.fake.credit_card_provider()
        )
        db.session.add(self.metodo_pago)
        
        # Crear tallas
        self.tallas = [
            Talla(nombre="S"),
            Talla(nombre="M"),
            Talla(nombre="L")
        ]
        db.session.add_all(self.tallas)
        
        # Crear categorías
        self.categorias = [
            Categoria(nombre="Zapatos"),
            Categoria(nombre="Ropa"),
            Categoria(nombre="Accesorios")
        ]
        db.session.add_all(self.categorias)
        
        # Crear géneros
        self.generos = [
            Genero(nombre="Hombre"),
            Genero(nombre="Mujer"),
            Genero(nombre="Unisex")
        ]
        db.session.add_all(self.generos)
        
        # Crear usuario
        self.usuario = Usuario(
            nombre=self.fake.name(),
            email=self.fake.email(),
            contrasena_hash=generate_password_hash("test123"),
            id_rol=self.rol_cliente.id,
            direccion=self.fake.address(),
            num_cel=self.fake.phone_number()
        )
        db.session.add(self.usuario)
        
        # Crear productos con inventario
        self.productos = []
        for i in range(3):  # 3 productos de prueba
            producto = Producto(
                nombre=f"Producto {self.fake.unique.word()}",
                precio=round(random.uniform(100, 5000), 2),
                id_categoria=random.choice(self.categorias).id,
                id_genero=random.choice(self.generos).id
            )
            db.session.add(producto)
            self.productos.append(producto)
            
            # Agregar inventario para cada talla
            for talla in self.tallas:
                db.session.add(Inventario(
                    id_producto=producto.id,
                    id_talla=talla.id,
                    stock=random.randint(5, 20)
                ))
        
        db.session.commit()
        
        # Token para autenticación
        self.token = create_access_token(identity=self.usuario.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_flujo_compra_completo(self):
        """Prueba completa: carrito -> compra -> verificación"""
        with self.app.app_context():
            # 1. Agregar múltiples productos al carrito
            items_carrito = []
            for producto in random.sample(self.productos, 2):  # 2 productos aleatorios
                talla = random.choice(self.tallas)
                cantidad = random.randint(1, 3)
                
                response = self.client.post(
                    '/carrito/productos',
                    json={
                        "producto_id": producto.id,
                        "id_talla": talla.id,
                        "cantidad": cantidad
                    },
                    headers={'Authorization': f'Bearer {self.token}'}
                )
                self.assertEqual(response.status_code, 200)
                items_carrito.append({
                    "producto": producto,
                    "talla": talla,
                    "cantidad": cantidad
                })
            
            # 2. Realizar compra
            compra_data = {
                "barrio": self.fake.city(),
                "observaciones": self.fake.sentence(),
                "metodo_pago_id": self.metodo_pago.id,
                "productos": [{
                    "id_producto": item["producto"].id,
                    "id_talla": item["talla"].id,
                    "cantidad": item["cantidad"],
                    "precio_unitario": item["producto"].precio
                } for item in items_carrito]
            }
            
            response = self.client.post(
                '/compras',
                json=compra_data,
                headers={'Authorization': f'Bearer {self.token}'}
            )
            self.assertEqual(response.status_code, 201)
            compra_id = json.loads(response.data)['compra_id']
            
            # 3. Verificar compra creada
            response = self.client.get(
                f'/compras/{compra_id}',
                headers={'Authorization': f'Bearer {self.token}'}
            )
            self.assertEqual(response.status_code, 200)
            compra = json.loads(response.data)
            self.assertEqual(len(compra['productos']), len(items_carrito))
            
            # 4. Verificar actualización de inventario
            for item in items_carrito:
                inventario = Inventario.query.filter_by(
                    id_producto=item["producto"].id,
                    id_talla=item["talla"].id
                ).first()
                self.assertLess(inventario.stock, 20)  # Verificar que se redujo el stock

    def test_compra_sin_stock(self):
        """Prueba intento de compra sin stock suficiente"""
        with self.app.app_context():
            # Seleccionar producto y talla
            producto = random.choice(self.productos)
            talla = random.choice(self.tallas)
            
            # Intentar comprar más de lo disponible
            inventario = Inventario.query.filter_by(
                id_producto=producto.id,
                id_talla=talla.id
            ).first()
            cantidad = inventario.stock + 1  # Cantidad mayor al stock
            
            # Agregar al carrito
            response = self.client.post(
                '/carrito/productos',
                json={
                    "producto_id": producto.id,
                    "id_talla": talla.id,
                    "cantidad": cantidad
                },
                headers={'Authorization': f'Bearer {self.token}'}
            )
            self.assertEqual(response.status_code, 400)  # Debe fallar
            
            # Verificar mensaje de error
            error_data = json.loads(response.data)
            self.assertIn("No hay suficiente stock", error_data['mensaje'])

    def test_historial_compras_usuario(self):
        """Prueba consulta de historial de compras"""
        with self.app.app_context():
            # Crear compra de prueba
            compra = Compra(
                barrio=self.fake.city(),
                usuario_id=self.usuario.id,
                metodo_pago_id=self.metodo_pago.id
            )
            db.session.add(compra)
            db.session.commit()
            
            # Consultar historial
            response = self.client.get(
                f'/usuario/{self.usuario.id}/compras',
                headers={'Authorization': f'Bearer {self.token}'}
            )
            self.assertEqual(response.status_code, 200)
            historial = json.loads(response.data)
            self.assertGreaterEqual(len(historial), 1)
            self.assertEqual(historial[0]['id'], compra.id)

if __name__ == '__main__':
    unittest.main()