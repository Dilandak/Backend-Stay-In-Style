# apis/test/conftest.py
import pytest
from faker import Faker
from flaskr import create_app, db
from flaskr.modelos import Rol, Usuario  # Importa tus modelos

@pytest.fixture(scope='module')
def app():
    app = create_app('testing')
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()

@pytest.fixture(scope='module')
def client(app):
    return app.test_client()

@pytest.fixture(scope='module')
def fake():
    return Faker('es_MX')

@pytest.fixture(scope='module')
def admin_user(app):
    with app.app_context():
        rol = Rol(nombre="Admin")
        db.session.add(rol)
        user = Usuario(
            nombre="Admin",
            email="admin@test.com",
            contrasena_hash="hash_falso",
            id_rol=1
        )
        db.session.add(user)
        db.session.commit()
        yield user