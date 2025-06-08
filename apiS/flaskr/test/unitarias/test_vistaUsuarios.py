import unittest
from unittest.mock import patch, MagicMock
from flask import json
from flask_jwt_extended import create_access_token
from werkzeug.security import generate_password_hash

from flaskr import create_app
from flaskr.modelos import db, Usuario, Rol
from flaskr.vistas import VistaUsuarios

class TestVistaUsuarios(unittest.TestCase):
    def setUp(self):
        self.app = create_app('testing')
        self.client = self.app.test_client()
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()

        # Datos de prueba
        self.rol_admin = Rol(nombre="Admin")
        self.rol_cliente = Rol(nombre="Cliente")
        db.session.add_all([self.rol_admin, self.rol_cliente])
        db.session.commit()

        self.usuario_admin = Usuario(
            nombre="Admin",
            email="admin@test.com",
            contrasena_hash=generate_password_hash("test123"),
            id_rol=self.rol_admin.id,
            estado="Activo"
        )
        db.session.add(self.usuario_admin)
        db.session.commit()

        self.token_admin = create_access_token(identity=self.usuario_admin.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_get_usuarios_autorizado(self):
        with self.client:
            response = self.client.get(
                '/usuarios',
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            self.assertEqual(response.status_code, 200)
            data = json.loads(response.data)
            self.assertIn('usuarios', data)
            self.assertGreater(len(data['usuarios']), 0)

    def test_post_usuario_valido(self):
        with self.client:
            nuevo_usuario = {
                "nombre": "Test User",
                "email": "test@test.com",
                "contrasena": "test123",
                "id_rol": self.rol_cliente.id
            }
            response = self.client.post(
                '/usuarios',
                json=nuevo_usuario,
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            self.assertEqual(response.status_code, 201)
            data = json.loads(response.data)
            self.assertEqual(data['email'], "test@test.com")

    def test_post_usuario_email_duplicado(self):
        with self.client:
            usuario_repetido = {
                "nombre": "Otro User",
                "email": "admin@test.com",  # Email ya existe
                "contrasena": "test123",
                "id_rol": self.rol_cliente.id
            }
            response = self.client.post(
                '/usuarios',
                json=usuario_repetido,
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            self.assertEqual(response.status_code, 409)

if __name__ == '__main__':
    unittest.main()