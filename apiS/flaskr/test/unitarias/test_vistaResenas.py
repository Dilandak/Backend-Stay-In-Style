import unittest
from unittest.mock import patch
from flask import json
from flask_jwt_extended import create_access_token
from datetime import datetime
from werkzeug.security import generate_password_hash
import os
import sys

# Ajuste de paths - ESTA ES LA LÍNEA CORREGIDA (cerré el paréntesis)
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..')))

from apis.flaskr import create_app, db
from apis.flaskr.modelos import Usuario, Producto, Reseña, Rol

class TestVistaResenas(unittest.TestCase):
    def setUp(self):
        self.app = create_app(config_name='testing')
        self.client = self.app.test_client()
        self.app_context = self.app.app_context()
        self.app_context.push()
        db.create_all()

        # Creación de datos de prueba CON TUS MODELOS EXACTOS
        self.rol = Rol(nombre="Cliente")
        db.session.add(self.rol)
        
        self.usuario = Usuario(
            nombre="Chicano Test",
            email="test@test.com",
            contrasena_hash=generate_password_hash("test123"),
            id_rol=self.rol.id,
            estado="Activo"
        )
        
        self.producto = Producto(
            nombre="Vans Classic",
            precio=999.99,
            estado="Disponible",
            id_categoria=1,
            id_genero=1
        )
        
        db.session.add_all([self.usuario, self.producto])
        db.session.commit()

        self.resena = Reseña(
            comentario="Están chingonas las Vans",
            calificacion=5,
            id_producto=self.producto.id,
            id_usuario=self.usuario.id
        )
        db.session.add(self.resena)
        db.session.commit()

        self.token = create_access_token(identity=self.usuario.id)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    # ---- PRUEBAS CORREGIDAS ----
    def test_eliminar_resena(self):
        """Prueba que verifica el borrado de reseñas"""
        with self.client:
            # Primero creamos una reseña nueva para borrar
            nueva_resena = Reseña(
                comentario="Temporal",
                calificacion=3,
                id_producto=self.producto.id,
                id_usuario=self.usuario.id
            )
            db.session.add(nueva_resena)
            db.session.commit()
            
            # La borramos
            response = self.client.delete(
                f'/reseña/{nueva_resena.id}',
                headers={'Authorization': f'Bearer {self.token}'}
            )
            
            self.assertEqual(response.status_code, 200)
            self.assertIsNone(Reseña.query.get(nueva_resena.id))

    def test_crear_resena_con_producto_inexistente(self):
        """Prueba que verifica error cuando el producto no existe"""
        with self.client:
            response = self.client.post(
                '/producto/99999/reseñas',
                json={
                    "comentario": "No existe",
                    "calificacion": 1,
                    "id_usuario": self.usuario.id
                },
                headers={'Authorization': f'Bearer {self.token}'}
            )
            self.assertEqual(response.status_code, 404)

if __name__ == '__main__':
    unittest.main()