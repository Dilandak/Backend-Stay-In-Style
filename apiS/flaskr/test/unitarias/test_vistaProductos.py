import unittest
from unittest.mock import patch
from flask import json
from cloudinary.uploader import upload

from flaskr import create_app
from flaskr.modelos import db, Producto, Categoria
from flaskr.vistas import VistaProductos, VistaProducto

class TestVistaProductos(unittest.TestCase):
    def setUp(self):
        self.app = create_app('testing')
        self.client = self.app.test_client()
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()

        # Datos de prueba
        self.categoria = Categoria(nombre="Ropa")
        db.session.add(self.categoria)
        db.session.commit()

        self.producto = Producto(
            nombre="Camiseta Test",
            precio=29.99,
            id_categoria=self.categoria.id,
            estado="Disponible"
        )
        db.session.add(self.producto)
        db.session.commit()

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_get_productos(self):
        with self.client:
            response = self.client.get('/productos')
            self.assertEqual(response.status_code, 200)
            data = json.loads(response.data)
            self.assertGreater(len(data), 0)
            self.assertEqual(data[0]['nombre'], "Camiseta Test")

    @patch('cloudinary.uploader.upload')
    def test_post_producto_valido(self, mock_upload):
        mock_upload.return_value = {'secure_url': 'http://test.com/image.jpg'}
        
        with self.client:
            nuevo_producto = {
                "nombre": "Pantalon Test",
                "precio": 49.99,
                "id_categoria": self.categoria.id,
                "id_genero": 1,
                "imagen": (open('tests/test_image.jpg', 'rb'), 'test_image.jpg')
            }
            
            response = self.client.post(
                '/productos',
                data=nuevo_producto,
                content_type='multipart/form-data'
            )
            
            self.assertEqual(response.status_code, 201)
            data = json.loads(response.data)
            self.assertEqual(data['nombre'], "Pantalon Test")
            self.assertTrue(mock_upload.called)

if __name__ == '__main__':
    unittest.main()