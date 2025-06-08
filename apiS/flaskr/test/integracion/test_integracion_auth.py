import unittest
import json
import sys
from os.path import dirname, abspath
from unittest.mock import patch
from faker import Faker
from werkzeug.security import generate_password_hash
from flask_jwt_extended import create_access_token

# Configurar path para imports
sys.path.insert(0, dirname(dirname(dirname(abspath(__file__)))))

from flaskr  import create_app, db, mail
from flaskr .modelos import Usuario, Rol

class TestIntegracionAuth(unittest.TestCase):
    def setUp(self):
        self.fake = Faker('es_MX')
        self.app = create_app('testing')
        self.client = self.app.test_client()
        
        # Configurar contexto de aplicación
        self.app_context = self.app.app_context()
        self.app_context.push()
        
        # Crear estructura de base de datos
        db.create_all()
        
        # Crear rol de cliente
        self.rol_cliente = Rol(nombre="Cliente")
        db.session.add(self.rol_cliente)
        db.session.commit()

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_flujo_completo_autenticacion(self):
        """Prueba registro -> login -> recuperación -> nuevo login"""
        # 1. Registro de usuario
        user_data = {
            "nombre": self.fake.name(),
            "email": self.fake.unique.email(),
            "password": self.fake.password(length=12),
            "num_cel": self.fake.phone_number(),
            "id_rol": self.rol_cliente.id
        }
        
        response = self.client.post('/registro', json=user_data)
        self.assertEqual(response.status_code, 201)
        user_id = json.loads(response.data)['id']
        
        # 2. Login con credenciales correctas
        response = self.client.post('/login', json={
            "email": user_data["email"],
            "password": user_data["password"]
        })
        self.assertEqual(response.status_code, 200)
        token = json.loads(response.data)['token']
        
        # 3. Verificar token accediendo a ruta protegida
        response = self.client.get(
            '/ruta-protegida',
            headers={'Authorization': f'Bearer {token}'}
        )
        self.assertIn(response.status_code, [200, 404])  # 404 si la ruta no existe
        
        # 4. Recuperación de contraseña
        with patch.object(mail, 'send') as mock_send:
            # Solicitar recuperación
            response = self.client.post('/forgot-password', json={
                "email": user_data["email"]
            })
            self.assertEqual(response.status_code, 200)
            
            # Verificar que se envió el correo
            self.assertTrue(mock_send.called)
            
            # Obtener token real generado (mejor que usar uno falso)
            usuario = Usuario.query.get(user_id)
            reset_token = usuario.reset_token
            self.assertIsNotNone(reset_token)
            
            # 5. Resetear contraseña
            new_password = self.fake.password(length=12)
            response = self.client.post(
                f'/reset-password/{reset_token}',
                json={"contrasena": new_password}
            )
            self.assertEqual(response.status_code, 200)
            
            # 6. Verificar nuevo login
            response = self.client.post('/login', json={
                "email": user_data["email"],
                "password": new_password
            })
            self.assertEqual(response.status_code, 200)
            
            # 7. Verificar que el token antiguo ya no funciona
            response = self.client.get(
                '/ruta-protegida',
                headers={'Authorization': f'Bearer {token}'}
            )
            self.assertEqual(response.status_code, 401)  # No autorizado

    def test_login_fallido(self):
        """Prueba credenciales incorrectas"""
        # Crear usuario directamente
        usuario = Usuario(
            nombre=self.fake.name(),
            email=self.fake.email(),
            contrasena_hash=generate_password_hash("password123"),
            id_rol=self.rol_cliente.id
        )
        db.session.add(usuario)
        db.session.commit()
        
        # Intentar login con contraseña incorrecta
        response = self.client.post('/login', json={
            "email": usuario.email,
            "password": "contraseña_incorrecta"
        })
        self.assertEqual(response.status_code, 401)
        
        # Verificar mensaje de error
        error_data = json.loads(response.data)
        self.assertIn("credenciales", error_data['mensaje'].lower())

    def test_registro_invalido(self):
        """Prueba registro con datos inválidos"""
        casos_invalidos = [
            {"email": "correo_invalido", "password": "123"},  # Email inválido
            {"email": self.fake.email(), "password": ""},     # Password vacío
            {}  # Datos vacíos
        ]
        
        for caso in casos_invalidos:
            response = self.client.post('/registro', json=caso)
            self.assertEqual(response.status_code, 400)
            
            error_data = json.loads(response.data)
            self.assertIn("error", error_data)

if __name__ == '__main__':
    unittest.main()