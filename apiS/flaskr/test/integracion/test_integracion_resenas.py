import unittest
import json
import random
from faker import Faker
from datetime import datetime
from werkzeug.security import generate_password_hash


import sys
from os.path import dirname, abspath
sys.path.insert(0, dirname(dirname(dirname(abspath(__file__)))))

from flaskr import create_app, db
from flaskr.modelos import Usuario, Producto, Reseña, Rol, Categoria

class TestIntegracionResenas(unittest.TestCase):
    def setUp(self):
        self.fake = Faker('es_MX')
        self.app = create_app('testing')
        self.client = self.app.test_client()
        
        # Crear contexto de aplicación
        self.app_context = self.app.app_context()
        self.app_context.push()
        
        # Crear base de datos
        db.create_all()
        
        # Crear datos de prueba
        self.rol = Rol(nombre="Cliente")
        self.categoria = Categoria(nombre="Zapatos")
        
        self.usuario = Usuario(
            nombre=self.fake.name(),
            email=self.fake.email(),
            contrasena_hash=generate_password_hash("test123"),
            id_rol=1
        )
        
        self.producto = Producto(
            nombre=f"Tenís {self.fake.color_name()}",
            precio=round(random.uniform(300, 2000), 2),
            id_categoria=1
        )
        
        db.session.add_all([self.rol, self.categoria, self.usuario, self.producto])
        db.session.commit()
        
        # Token para autenticación
        self.token = create_access_token(identity=self.usuario.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_crear_resena(self):
        """Prueba crear una reseña con datos generados"""
        resena_data = {
            "comentario": self.fake.sentence(),
            "calificacion": random.randint(1, 5),
            "id_usuario": self.usuario.id
        }
        
        response = self.client.post(
            f'/producto/{self.producto.id}/reseñas',
            json=resena_data,
            headers={'Authorization': f'Bearer {self.token}'}
        )
        
        self.assertEqual(response.status_code, 201)
        data = json.loads(response.data)
        self.assertEqual(data['mensaje'], "Reseña creada exitosamente")

if __name__ == '__main__':
    unittest.main()