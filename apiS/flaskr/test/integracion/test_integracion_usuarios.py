import unittest
import json
import random
import sys
from os.path import dirname, abspath
from faker import Faker
from datetime import datetime
from werkzeug.security import generate_password_hash
from flask_jwt_extended import create_access_token

# Asegurar que Python encuentre los módulos
sys.path.insert(0, dirname(dirname(dirname(abspath(__file__)))))

from flaskr import create_app, db
from flaskr.modelos import Usuario, Rol, Producto, Categoria, Carrito, Inventario, MetodoPago, Genero, Talla, Reseña, Compra

class TestIntegracionUsuarios(unittest.TestCase):
    def setUp(self):
        self.fake = Faker('es_MX')  # Datos en español
        self.app = create_app('testing')
        self.client = self.app.test_client()
        
        # Configurar contexto de aplicación
        self.app_context = self.app.app_context()
        self.app_context.push()
        
        # Crear estructura de base de datos
        db.create_all()
        
        # Crear roles de prueba
        self.rol_admin = Rol(nombre="Admin")
        self.rol_cliente = Rol(nombre="Cliente")
        db.session.add_all([self.rol_admin, self.rol_cliente])
        
        # Crear usuario admin
        self.admin = Usuario(
            nombre=self.fake.name(),
            email="admin@test.com",
            contrasena_hash=generate_password_hash("admin123"),
            id_rol=self.rol_admin.id,
            estado="Activo",
            num_cel=self.fake.phone_number(),
            direccion=self.fake.address()
        )
        db.session.add(self.admin)
        db.session.commit()
        
        # Generar token JWT
        self.token_admin = create_access_token(identity=self.admin.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_flujo_usuario_con_faker(self):
        """Prueba completa con datos generados automáticamente"""
        with self.app.app_context():
            # Generar datos falsos
            user_data = {
                "nombre": self.fake.name(),
                "email": self.fake.unique.email(),
                "contrasena": self.fake.password(length=12),
                "num_cel": self.fake.phone_number(),
                "direccion": self.fake.address(),
                "id_rol": self.rol_cliente.id,
                "estado": "Activo"
            }

            # 1. Crear usuario
            response = self.client.post(
                '/usuarios',
                json=user_data,
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            self.assertEqual(response.status_code, 201)
            
            # 2. Verificar creación
            user_id = json.loads(response.data)['id']
            response = self.client.get(
                f'/usuario/{user_id}',
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            data = json.loads(response.data)
            self.assertEqual(response.status_code, 200)
            self.assertEqual(data['email'], user_data['email'])
            self.assertEqual(data['id_rol'], user_data['id_rol'])
            
            # 3. Actualizar usuario
            update_data = {
                "direccion": self.fake.address(),
                "num_cel": self.fake.phone_number()
            }
            response = self.client.put(
                f'/usuario/{user_id}',
                json=update_data,
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            self.assertEqual(response.status_code, 200)
            
            # 4. Eliminar usuario
            response = self.client.delete(
                f'/usuario/{user_id}',
                headers={'Authorization': f'Bearer {self.token_admin}'}
            )
            self.assertEqual(response.status_code, 204)

if __name__ == '__main__':
    unittest.main()