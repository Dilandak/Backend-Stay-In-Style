import unittest
import json
import random
import sys
from os.path import dirname, abspath
from unittest.mock import patch
from faker import Faker
from werkzeug.security import generate_password_hash
from flask_jwt_extended import create_access_token

# Configurar path para imports
sys.path.insert(0, dirname(dirname(dirname(abspath(__file__)))))

from flaskr import create_app, db
from flaskr.modelos import (Usuario, Producto, Categoria, Genero, 
                          Rol, Inventario, Talla)

class TestIntegracionProductos(unittest.TestCase):
    def setUp(self):
        self.fake = Faker('es_MX')
        self.app = create_app('testing')
        self.client = self.app.test_client()
        
        # Configurar contexto de aplicación
        self.app_context = self.app.app_context()
        self.app_context.push()
        
        # Crear estructura de base de datos
        db.create_all()
        
        # Crear datos básicos
        self.rol_admin = Rol(nombre="Admin")
        db.session.add(self.rol_admin)
        
        # Crear usuario admin
        self.admin = Usuario(
            nombre=self.fake.name(),
            email="admin@test.com",
            contrasena_hash=generate_password_hash("admin123"),
            id_rol=self.rol_admin.id
        )
        db.session.add(self.admin)
        
        # Crear categorías y géneros
        self.categorias = [
            Categoria(nombre="Zapatos"),
            Categoria(nombre="Ropa"),
            Categoria(nombre="Accesorios")
        ]
        
        self.generos = [
            Genero(nombre="Hombre"),
            Genero(nombre="Mujer"),
            Genero(nombre="Unisex")
        ]
        
        db.session.add_all(self.categorias + self.generos)
        db.session.commit()
        
        # Token para autenticación
        self.token_admin = create_access_token(identity=self.admin.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    @patch('cloudinary.uploader.upload')
    def test_creacion_producto_con_faker(self, mock_upload):
        """Prueba creación de producto con imagen simulada"""
        mock_upload.return_value = {'secure_url': self.fake.image_url()}
        
        producto_data = {
            "nombre": f"{self.fake.word().capitalize()} {self.fake.word()}",
            "precio": round(random.uniform(100, 5000), 2),
            "descripcion": self.fake.paragraph(),
            "id_categoria": random.choice([c.id for c in self.categorias]),
            "id_genero": random.choice([g.id for g in self.generos]),
            "imagen": (io.BytesIO(b"fake image data"), "test.jpg")
        }

        response = self.client.post(
            '/productos',
            data=producto_data,
            content_type='multipart/form-data',
            headers={'Authorization': f'Bearer {self.token_admin}'}
        )
        
        self.assertEqual(response.status_code, 201)
        data = json.loads(response.data)
        
        # Verificaciones
        self.assertIn('id', data)
        self.assertEqual(float(data['precio']), producto_data['precio'])
        self.assertEqual(data['id_categoria'], producto_data['id_categoria'])
        self.assertTrue(mock_upload.called)

    def test_busqueda_productos(self):
        """Prueba sistema de búsqueda con datos reales"""
        # Crear productos de prueba
        productos = [
            Producto(
                nombre=f"Producto {self.fake.unique.word()}",
                precio=round(random.uniform(100, 2000), 2),
                id_categoria=random.choice([c.id for c in self.categorias]),
                id_genero=random.choice([g.id for g in self.generos])
            ) for _ in range(5)
        ]
        db.session.add_all(productos)
        db.session.commit()

        # Buscar por término aleatorio
        search_term = random.choice(["zap", "rop", "acc"])
        response = self.client.get(f'/productos?search={search_term}')
        
        self.assertEqual(response.status_code, 200)
        results = json.loads(response.data)
        self.assertGreater(len(results), 0)

    def test_actualizacion_producto(self):
        """Prueba actualización de producto existente"""
        # Crear producto inicial
        producto = Producto(
            nombre="Producto Original",
            precio=100.00,
            id_categoria=self.categorias[0].id,
            id_genero=self.generos[0].id
        )
        db.session.add(producto)
        db.session.commit()

        # Datos de actualización
        update_data = {
            "nombre": "Producto Actualizado",
            "precio": 150.00,
            "descripcion": self.fake.sentence()
        }

        response = self.client.put(
            f'/producto/{producto.id}',
            json=update_data,
            headers={'Authorization': f'Bearer {self.token_admin}'}
        )
        
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data['nombre'], "Producto Actualizado")
        self.assertEqual(float(data['precio']), 150.00)

if __name__ == '__main__':
    unittest.main()