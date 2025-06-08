import unittest
from werkzeug.security import generate_password_hash

from flaskr import create_app
from flaskr.modelos import db, Usuario
from flaskr.vistas import VistaInicioSesion

class TestVistaAuth(unittest.TestCase):
    def setUp(self):
        self.app = create_app('testing')
        self.client = self.app.test_client()
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()

        # Usuario de prueba
        self.usuario = Usuario(
            nombre="Test User",
            email="test@test.com",
            contrasena_hash=generate_password_hash("test123")
        )
        db.session.add(self.usuario)
        db.session.commit()

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_login_valido(self):
        with self.client:
            credenciales = {
                "email": "test@test.com",
                "password": "test123"
            }
            response = self.client.post(
                '/login',
                json=credenciales
            )
            self.assertEqual(response.status_code, 200)
            data = json.loads(response.data)
            self.assertIn('token', data)

    def test_login_invalido(self):
        with self.client:
            credenciales = {
                "email": "test@test.com",
                "password": "contraseña_incorrecta"
            }
            response = self.client.post(
                '/login',
                json=credenciales
            )
            self.assertEqual(response.status_code, 401)

if __name__ == '__main__':
    unittest.main()