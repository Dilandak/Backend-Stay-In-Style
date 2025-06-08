import unittest
from flask import json
from flask_jwt_extended import create_access_token

from flaskr import create_app
from flaskr.modelos import db, Usuario, Carrito, Producto, Talla, Inventario

class TestVistaCarrito(unittest.TestCase):
    def setUp(self):
        self.app = create_app('testing')
        self.client = self.app.test_client()
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()

        # Datos de prueba
        self.usuario = Usuario(
            nombre="Test User",
            email="test@test.com",
            contrasena_hash="test123"
        )
        db.session.add(self.usuario)
        db.session.commit()

        self.token = create_access_token(identity=self.usuario.id)

        self.talla = Talla(nombre="M")
        self.producto = Producto(nombre="Producto Test", precio=19.99)
        db.session.add_all([self.talla, self.producto])
        db.session.commit()

        self.inventario = Inventario(
            id_producto=self.producto.id,
            id_talla=self.talla.id,
            stock=10
        )
        db.session.add(self.inventario)
        db.session.commit()

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_agregar_producto_carrito(self):
        with self.client:
            data = {
                "producto_id": self.producto.id,
                "id_talla": self.talla.id,
                "cantidad": 2
            }
            
            response = self.client.post(
                '/carrito/productos',
                json=data,
                headers={'Authorization': f'Bearer {self.token}'}
            )
            
            self.assertEqual(response.status_code, 200)
            data = json.loads(response.data)
            self.assertEqual(data['carrito']['productos'][0]['nombre'], "Producto Test")

if __name__ == '__main__':
    unittest.main()