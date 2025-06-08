import unittest
from flask import json
from flask_jwt_extended import create_access_token

from flaskr import create_app
from flaskr.modelos import db, Usuario, MetodoPago, Producto, Talla, Inventario

class TestVistaCompras(unittest.TestCase):
    def setUp(self):
        self.app = create_app('testing')
        self.client = self.app.test_client()
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()

        # Datos de prueba
        self.usuario = Usuario(
            nombre="Comprador",
            email="compra@test.com",
            contrasena_hash="test123"
        )
        self.metodo_pago = MetodoPago(tipo="Tarjeta", detalle="Visa")
        self.talla = Talla(nombre="L")
        self.producto = Producto(nombre="Producto Compra", precio=25.99)
        
        db.session.add_all([
            self.usuario, 
            self.metodo_pago,
            self.talla,
            self.producto
        ])
        db.session.commit()

        self.inventario = Inventario(
            id_producto=self.producto.id,
            id_talla=self.talla.id,
            stock=5
        )
        db.session.add(self.inventario)
        db.session.commit()

        self.token = create_access_token(identity=self.usuario.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_crear_compra_valida(self):
        with self.client:
            data = {
                "barrio": "Centro",
                "metodo_pago_id": self.metodo_pago.id,
                "productos": [
                    {
                        "id_producto": self.producto.id,
                        "id_talla": self.talla.id,
                        "cantidad": 1,
                        "precio_unitario": self.producto.precio
                    }
                ]
            }
            
            response = self.client.post(
                '/compras',
                json=data,
                headers={'Authorization': f'Bearer {self.token}'}
            )
            
            self.assertEqual(response.status_code, 201)
            data = json.loads(response.data)
            self.assertIn('compra_id', data)

if __name__ == '__main__':
    unittest.main()