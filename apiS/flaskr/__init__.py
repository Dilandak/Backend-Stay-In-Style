from flask import Flask, Blueprint
from flask_restx import Api as RestXApi, Namespace, Resource, fields
from flask_restful import Api
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from flask_cors import CORS
from .modelos import db
from .vistas import (
    VistaUsuarios, VistaUsuario, VistaProductos, VistaProducto, VistaPedidos,
    VistaPedido, VistaReseñas, VistaReseña, VistaCrearUsuario, VistaRegistroUsuarios,
    VistaInicioSesion, VistaCrearProducto, VistaMetodosPago, VistaCrearPedido,
    VistaCrearReseña, VistaForgotPassword, VistaResetPassword, VistaCrearCompra,
    VistaComprasUsuario, VistaCompras, VistaCompra, VistaReseñasProducto, 
    VistaNotificaciones,VistaCategorias,VistaCategoria, VistaReporteVentas,VistaRoles,VistaCarritos,VistaCarrito,VistaCarritoProductos,VistaInventarioProducto,VistaInventarioItem,VistaTallas,VistaTallasDisponibles,VistaTallasDisponibles,VistaGeneroDisponible,VistaHistorialCompras,VistaHistorialStock,VistaHistorialStockProducto,VistaCrearHistorialStock,VistaDisponibilidadProducto# CARRITOO,
)
from .extensiones import mail  # 💌 Importamos mail desde extensiones.py (nuevo archivo)
from .utils.email import enviar_correo  # ✅ CAMBIADO: Importación relativa correcta
def create_app():
    app = Flask(__name__)
    api = Api(app)

    # ===== Configuración de la app =====
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://stayprueba_qpys_user:2DuD58ElJeNhvdQbUTEYN7KUWVm20em5@dpg-d1103lqli9vc7388qskg-a/stayprueba_qpys'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = 'supersecretkey'

    db.init_app(app)
    migrate = Migrate(app, db)
    jwt = JWTManager(app)
     # 💌 Configuración de Flask-Mail
    app.config['MAIL_SERVER'] = 'smtp.gmail.com'
    app.config['MAIL_PORT'] = 465
    app.config['MAIL_USE_SSL'] = True
    app.config['MAIL_USERNAME'] = 'dilandakrg@gmail.com'
    app.config['MAIL_PASSWORD'] = 'aqipmvprqtmjotbv'
    app.config['MAIL_DEFAULT_SENDER'] = 'dilandakrg@gmail.com'
    mail.init_app(app)
    CORS(app)

    # ===== API RESTful (funcional) =====
    api_restful = Api(app)

    # CRUD con Flask-RESTful
    api_restful.add_resource(VistaUsuarios, '/usuarios')
    api_restful.add_resource(VistaUsuario, '/usuarios/<int:id_usuario>')
    api_restful.add_resource(VistaProductos, '/productos')
    api_restful.add_resource(VistaProducto, '/productos/<int:id_producto>')
    api_restful.add_resource(VistaCrearProducto, '/productos/nuevo')
    api_restful.add_resource(VistaPedidos, '/pedidos')
    api_restful.add_resource(VistaPedido, '/pedidos/<int:id_pedido>')
    api_restful.add_resource(VistaCrearPedido, '/pedidos/nuevo')

    api_restful.add_resource(VistaReseñas, '/reseñas')
    api_restful.add_resource(VistaReseña, '/reseñas/<int:id_resena>')
    api_restful.add_resource(VistaReseñasProducto, '/productos/<int:id_producto>/reseñas') 
    api_restful.add_resource(VistaCrearReseña, '/productos/<int:id_producto>/crear-reseña') 

    api_restful.add_resource(VistaCrearUsuario, '/registrar_usuario')
    api_restful.add_resource(VistaRegistroUsuarios, '/registro')
    api_restful.add_resource(VistaInicioSesion, '/login')
    api_restful.add_resource(VistaMetodosPago, '/metodos_pago')
    api_restful.add_resource(VistaForgotPassword, '/forgot-password')
    api_restful.add_resource(VistaResetPassword, '/reset-password/<string:token>')
    api_restful.add_resource(VistaCrearCompra, '/Crearcompras')
    api.add_resource(VistaCompra, '/compras', '/compras/<int:id_compra>')
    api.add_resource(VistaCompras, '/compras/todas')
    api.add_resource(VistaComprasUsuario, '/usuarios/<int:id_usuario>/compras')

    api.add_resource(VistaNotificaciones, '/notificaciones')
    
    api.add_resource(VistaReporteVentas, '/reportes/ventas')

    #Categorias
    api.add_resource(VistaCategorias, '/categorias')
    api.add_resource(VistaCategoria, '/categorias/<int:id_categoria>')


    api.add_resource(VistaRoles, '/roles')

    # CARRITO 
    api.add_resource(VistaCarritos, '/api/carritos')
    api.add_resource(VistaCarrito, '/api/carritos/<int:id_carrito>')
    api.add_resource(VistaCarritoProductos, '/api/carritos/productos')

    #
    api.add_resource(VistaInventarioProducto, '/api/productos/<int:id_producto>/inventario')
    api.add_resource(VistaInventarioItem, '/api/inventario/<int:id_inventario>')

    # CREAR TALLAS 
    api.add_resource(VistaTallas, '/api/productos/<int:id_producto>/tallas-disponibles')

    # Tallas dispoibles
    api.add_resource(VistaTallasDisponibles, '/api/tallas')

    #Generos
    api.add_resource(VistaGeneroDisponible, '/api/generos')

    #Historial de compras
    api_restful.add_resource(VistaHistorialCompras, '/api/mis-compras')

    # Historial stock
    api.add_resource(VistaHistorialStock, '/api/historial-stock')

    api.add_resource(VistaHistorialStockProducto, '/api/historial-stock/producto/<int:id_producto>')

    api.add_resource(VistaCrearHistorialStock, '/api/historial-stock/crear')

    api.add_resource(VistaDisponibilidadProducto, '/api/producto/<int:id_producto>/disponibilidad')


# ===== Documentación SWAGGER con Flask-RestX =====
    blueprint = Blueprint('api', __name__, url_prefix='/api')
    api = RestXApi(
        blueprint,
        version='1.0',
        title='Stay API - Documentación Completa',
        description='Documentación completa para todos los endpoints de la API',
        doc='/swagger/',
        authorizations={
            'Bearer Auth': {
                'type': 'apiKey',
                'in': 'header',
                'name': 'Authorization',
                'description': 'Bearer <token_jwt>'
            }
        }
    )
    app.register_blueprint(blueprint)
    app.config['RESTX_MASK_SWAGGER'] = False

    # ===== MODELOS DOCUMENTADOS =====
    usuario_model = api.model('Usuario', {
        'id': fields.Integer(readOnly=True),
        'nombre': fields.String(required=True, example="Juan Pérez"),
        'email': fields.String(required=True, example="juan@example.com"),
        'password': fields.String(required=True),
        'estado': fields.String(enum=['Activo', 'Inactivo'])
    })

    producto_model = api.model('Producto', {
        'id': fields.Integer(readOnly=True),
        'nombre': fields.String(required=True, example="Zapatos deportivos"),
        'precio': fields.Float(required=True, example=99.99),
        'descripcion': fields.String(required=True),
        'imagen': fields.String(),
        'estado': fields.String(enum=['Disponible', 'Agotado'])
    })

    reseña_model = api.model('Reseña', {
        'id': fields.Integer(readOnly=True),
        'comentario': fields.String(required=True),
        'calificacion': fields.Integer(min=1, max=5, example=5),
        'fecha_creacion': fields.DateTime(),
        'producto': fields.Nested(producto_model),
        'usuario': fields.Nested(usuario_model)
    })

    pedido_model = api.model('Pedido', {
        'id': fields.Integer(readOnly=True),
        'total_pedido': fields.Float(required=True, example=150.50),
        'direccion_envio': fields.String(required=True),
        'fecha_pedido': fields.DateTime(),
        'estado_pedido': fields.String(enum=['Procesado', 'Enviado', 'Entregado'])
    })

    compra_model = api.model('Compra', {
        'id': fields.Integer(readOnly=True),
        'id_usuario': fields.Integer(required=True),
        'id_producto': fields.Integer(required=True),
        'cantidad': fields.Integer(required=True),
        'precio_unitario': fields.Float(required=True),
        'total': fields.Float(required=True),
        'fecha_compra': fields.DateTime()
    })

    categoria_model = api.model('Categoria', {
        'id': fields.Integer(readOnly=True),
        'nombre': fields.String(required=True, example="Calzado"),
        'descripcion': fields.String(example="Todo tipo de calzado")
    })

    carrito_model = api.model('Carrito', {
        'id': fields.Integer(readOnly=True),
        'id_usuario': fields.Integer(required=True),
        'fecha_creacion': fields.DateTime(),
        'estado': fields.String(enum=['Activo', 'Completado', 'Abandonado'])
    })

    inventario_model = api.model('Inventario', {
        'id': fields.Integer(readOnly=True),
        'id_producto': fields.Integer(required=True),
        'talla': fields.String(required=True, example="M"),
        'cantidad': fields.Integer(required=True, example=10),
        'genero': fields.String(enum=['Hombre', 'Mujer', 'Unisex'])
    })

    talla_model = api.model('Talla', {
        'id': fields.Integer(readOnly=True),
        'talla': fields.String(required=True, example="M"),
        'descripcion': fields.String(example="Mediana")
    })

    genero_model = api.model('Genero', {
        'id': fields.Integer(readOnly=True),
        'nombre': fields.String(required=True, example="Hombre"),
        'descripcion': fields.String(example="Ropa para hombres")
    })

    historial_stock_model = api.model('HistorialStock', {
        'id': fields.Integer(readOnly=True),
        'id_producto': fields.Integer(required=True),
        'cantidad_anterior': fields.Integer(required=True),
        'cantidad_nueva': fields.Integer(required=True),
        'fecha_modificacion': fields.DateTime(),
        'motivo': fields.String(example="Reabastecimiento")
    })

    # ===== NAMESPACES CON DOCUMENTACIÓN =====
    users_ns = Namespace('Usuarios', description='CRUD para usuarios', path='/usuarios')
    products_ns = Namespace('Productos', description='CRUD para productos', path='/productos')
    reviews_ns = Namespace('Reseñas', description='CRUD para reseñas', path='/reseñas')
    orders_ns = Namespace('Pedidos', description='CRUD para pedidos', path='/pedidos')
    purchases_ns = Namespace('Compras', description='CRUD para compras', path='/compras')
    categories_ns = Namespace('Categorias', description='CRUD para categorías', path='/categorias')
    carts_ns = Namespace('Carritos', description='CRUD para carritos de compra', path='/carritos')
    inventory_ns = Namespace('Inventario', description='Gestión de inventario', path='/inventario')
    sizes_ns = Namespace('Tallas', description='Gestión de tallas', path='/tallas')
    genders_ns = Namespace('Géneros', description='Gestión de géneros', path='/generos')
    stock_history_ns = Namespace('HistorialStock', description='Historial de cambios en stock', path='/historial-stock')
    notifications_ns = Namespace('Notificaciones', description='Gestión de notificaciones', path='/notificaciones')
    reports_ns = Namespace('Reportes', description='Generación de reportes', path='/reportes')
    roles_ns = Namespace('Roles', description='Gestión de roles de usuario', path='/roles')

    # Usuarios
    @users_ns.route('/')
    class UsuarioList(Resource):
        @users_ns.doc('listar_usuarios', security='Bearer Auth')
        @users_ns.marshal_list_with(usuario_model)
        def get(self):
            """Lista todos los usuarios"""
            pass

        @users_ns.doc('crear_usuario')
        @users_ns.expect(usuario_model)
        @users_ns.marshal_with(usuario_model, code=201)
        def post(self):
            """Crea un nuevo usuario"""
            pass

    @users_ns.route('/<int:id_usuario>')
    class UsuarioDetail(Resource):
        @users_ns.doc('obtener_usuario', security='Bearer Auth')
        @users_ns.marshal_with(usuario_model)
        def get(self, id_usuario):
            """Obtiene un usuario específico"""
            pass

        @users_ns.doc('actualizar_usuario', security='Bearer Auth')
        @users_ns.expect(usuario_model)
        @users_ns.marshal_with(usuario_model)
        def put(self, id_usuario):
            """Actualiza un usuario existente"""
            pass

        @users_ns.doc('eliminar_usuario', security='Bearer Auth')
        @users_ns.response(204, 'Usuario eliminado')
        def delete(self, id_usuario):
            """Elimina un usuario"""
            pass

    # Productos
    @products_ns.route('/')
    class ProductoList(Resource):
        @products_ns.doc('listar_productos')
        @products_ns.marshal_list_with(producto_model)
        def get(self):
            """Lista todos los productos"""
            pass

        @products_ns.doc('crear_producto', security='Bearer Auth')
        @products_ns.expect(producto_model)
        @products_ns.marshal_with(producto_model, code=201)
        def post(self):
            """Crea un nuevo producto"""
            pass

    @products_ns.route('/<int:id_producto>')
    class ProductoDetail(Resource):
        @products_ns.doc('obtener_producto')
        @products_ns.marshal_with(producto_model)
        def get(self, id_producto):
            """Obtiene un producto específico"""
            pass

        @products_ns.doc('actualizar_producto', security='Bearer Auth')
        @products_ns.expect(producto_model)
        @products_ns.marshal_with(producto_model)
        def put(self, id_producto):
            """Actualiza un producto existente"""
            pass

        @products_ns.doc('eliminar_producto', security='Bearer Auth')
        @products_ns.response(204, 'Producto eliminado')
        def delete(self, id_producto):
            """Elimina un producto"""
            pass

    # Reseñas
    @reviews_ns.route('/')
    class ReseñaList(Resource):
        @reviews_ns.doc('listar_reseñas')
        @reviews_ns.marshal_list_with(reseña_model)
        def get(self):
            """Lista todas las reseñas"""
            pass

    @reviews_ns.route('/<int:id_resena>')
    class ReseñaDetail(Resource):
        @reviews_ns.doc('obtener_reseña')
        @reviews_ns.marshal_with(reseña_model)
        def get(self, id_resena):
            """Obtiene una reseña específica"""
            pass

        @reviews_ns.doc('actualizar_reseña', security='Bearer Auth')
        @reviews_ns.expect(reseña_model)
        @reviews_ns.marshal_with(reseña_model)
        def put(self, id_resena):
            """Actualiza una reseña existente"""
            pass

        @reviews_ns.doc('eliminar_reseña', security='Bearer Auth')
        @reviews_ns.response(204, 'Reseña eliminada')
        def delete(self, id_resena):
            """Elimina una reseña"""
            pass

    @reviews_ns.route('/producto/<int:id_producto>')
    class ReseñasProducto(Resource):
        @reviews_ns.doc('reseñas_por_producto')
        @reviews_ns.marshal_list_with(reseña_model)
        def get(self, id_producto):
            """Obtiene todas las reseñas de un producto específico"""
            pass

    # Pedidos
    @orders_ns.route('/')
    class PedidoList(Resource):
        @orders_ns.doc('listar_pedidos', security='Bearer Auth')
        @orders_ns.marshal_list_with(pedido_model)
        def get(self):
            """Lista todos los pedidos"""
            pass

        @orders_ns.doc('crear_pedido', security='Bearer Auth')
        @orders_ns.expect(pedido_model)
        @orders_ns.marshal_with(pedido_model, code=201)
        def post(self):
            """Crea un nuevo pedido"""
            pass

    @orders_ns.route('/<int:id_pedido>')
    class PedidoDetail(Resource):
        @orders_ns.doc('obtener_pedido', security='Bearer Auth')
        @orders_ns.marshal_with(pedido_model)
        def get(self, id_pedido):
            """Obtiene un pedido específico"""
            pass

        @orders_ns.doc('actualizar_pedido', security='Bearer Auth')
        @orders_ns.expect(pedido_model)
        @orders_ns.marshal_with(pedido_model)
        def put(self, id_pedido):
            """Actualiza un pedido existente"""
            pass

        @orders_ns.doc('eliminar_pedido', security='Bearer Auth')
        @orders_ns.response(204, 'Pedido eliminado')
        def delete(self, id_pedido):
            """Elimina un pedido"""
            pass

    # Compras
    @purchases_ns.route('/')
    class CompraList(Resource):
        @purchases_ns.doc('listar_compras', security='Bearer Auth')
        @purchases_ns.marshal_list_with(compra_model)
        def get(self):
            """Lista todas las compras"""
            pass

        @purchases_ns.doc('crear_compra', security='Bearer Auth')
        @purchases_ns.expect(compra_model)
        @purchases_ns.marshal_with(compra_model, code=201)
        def post(self):
            """Crea una nueva compra"""
            pass

    @purchases_ns.route('/<int:id_compra>')
    class CompraDetail(Resource):
        @purchases_ns.doc('obtener_compra', security='Bearer Auth')
        @purchases_ns.marshal_with(compra_model)
        def get(self, id_compra):
            """Obtiene una compra específica"""
            pass

    @purchases_ns.route('/usuario/<int:id_usuario>')
    class ComprasUsuario(Resource):
        @purchases_ns.doc('compras_por_usuario', security='Bearer Auth')
        @purchases_ns.marshal_list_with(compra_model)
        def get(self, id_usuario):
            """Obtiene todas las compras de un usuario específico"""
            pass

    # Categorías
    @categories_ns.route('/')
    class CategoriaList(Resource):
        @categories_ns.doc('listar_categorias')
        @categories_ns.marshal_list_with(categoria_model)
        def get(self):
            """Lista todas las categorías"""
            pass

        @categories_ns.doc('crear_categoria', security='Bearer Auth')
        @categories_ns.expect(categoria_model)
        @categories_ns.marshal_with(categoria_model, code=201)
        def post(self):
            """Crea una nueva categoría"""
            pass

    @categories_ns.route('/<int:id_categoria>')
    class CategoriaDetail(Resource):
        @categories_ns.doc('obtener_categoria')
        @categories_ns.marshal_with(categoria_model)
        def get(self, id_categoria):
            """Obtiene una categoría específica"""
            pass

        @categories_ns.doc('actualizar_categoria', security='Bearer Auth')
        @categories_ns.expect(categoria_model)
        @categories_ns.marshal_with(categoria_model)
        def put(self, id_categoria):
            """Actualiza una categoría existente"""
            pass

        @categories_ns.doc('eliminar_categoria', security='Bearer Auth')
        @categories_ns.response(204, 'Categoría eliminada')
        def delete(self, id_categoria):
            """Elimina una categoría"""
            pass

    # Carritos
    @carts_ns.route('/')
    class CarritoList(Resource):
        @carts_ns.doc('listar_carritos', security='Bearer Auth')
        @carts_ns.marshal_list_with(carrito_model)
        def get(self):
            """Lista todos los carritos"""
            pass

        @carts_ns.doc('crear_carrito', security='Bearer Auth')
        @carts_ns.expect(carrito_model)
        @carts_ns.marshal_with(carrito_model, code=201)
        def post(self):
            """Crea un nuevo carrito"""
            pass

    @carts_ns.route('/<int:id_carrito>')
    class CarritoDetail(Resource):
        @carts_ns.doc('obtener_carrito', security='Bearer Auth')
        @carts_ns.marshal_with(carrito_model)
        def get(self, id_carrito):
            """Obtiene un carrito específico"""
            pass

        @carts_ns.doc('actualizar_carrito', security='Bearer Auth')
        @carts_ns.expect(carrito_model)
        @carts_ns.marshal_with(carrito_model)
        def put(self, id_carrito):
            """Actualiza un carrito existente"""
            pass

        @carts_ns.doc('eliminar_carrito', security='Bearer Auth')
        @carts_ns.response(204, 'Carrito eliminado')
        def delete(self, id_carrito):
            """Elimina un carrito"""
            pass

    # Inventario
    @inventory_ns.route('/producto/<int:id_producto>')
    class InventarioProducto(Resource):
        @inventory_ns.doc('inventario_por_producto')
        @inventory_ns.marshal_list_with(inventario_model)
        def get(self, id_producto):
            """Obtiene el inventario de un producto específico"""
            pass

        @inventory_ns.doc('agregar_inventario', security='Bearer Auth')
        @inventory_ns.expect(inventario_model)
        @inventory_ns.marshal_with(inventario_model, code=201)
        def post(self, id_producto):
            """Agrega un nuevo item al inventario de un producto"""
            pass

    @inventory_ns.route('/<int:id_inventario>')
    class InventarioItem(Resource):
        @inventory_ns.doc('obtener_item_inventario')
        @inventory_ns.marshal_with(inventario_model)
        def get(self, id_inventario):
            """Obtiene un item específico del inventario"""
            pass

        @inventory_ns.doc('actualizar_item_inventario', security='Bearer Auth')
        @inventory_ns.expect(inventario_model)
        @inventory_ns.marshal_with(inventario_model)
        def put(self, id_inventario):
            """Actualiza un item del inventario"""
            pass

        @inventory_ns.doc('eliminar_item_inventario', security='Bearer Auth')
        @inventory_ns.response(204, 'Item eliminado')
        def delete(self, id_inventario):
            """Elimina un item del inventario"""
            pass

    # Tallas
    @sizes_ns.route('/')
    class TallaList(Resource):
        @sizes_ns.doc('listar_tallas')
        @sizes_ns.marshal_list_with(talla_model)
        def get(self):
            """Lista todas las tallas disponibles"""
            pass

    # Géneros
    @genders_ns.route('/')
    class GeneroList(Resource):
        @genders_ns.doc('listar_generos')
        @genders_ns.marshal_list_with(genero_model)
        def get(self):
            """Lista todos los géneros disponibles"""
            pass

    # Historial de Stock
    @stock_history_ns.route('/')
    class HistorialStockList(Resource):
        @stock_history_ns.doc('listar_historial_stock', security='Bearer Auth')
        @stock_history_ns.marshal_list_with(historial_stock_model)
        def get(self):
            """Lista todo el historial de cambios en stock"""
            pass

        @stock_history_ns.doc('crear_historial_stock', security='Bearer Auth')
        @stock_history_ns.expect(historial_stock_model)
        @stock_history_ns.marshal_with(historial_stock_model, code=201)
        def post(self):
            """Registra un nuevo cambio en el stock"""
            pass

    @stock_history_ns.route('/producto/<int:id_producto>')
    class HistorialStockProducto(Resource):
        @stock_history_ns.doc('historial_stock_por_producto', security='Bearer Auth')
        @stock_history_ns.marshal_list_with(historial_stock_model)
        def get(self, id_producto):
            """Obtiene el historial de cambios de stock para un producto específico"""
            pass

    # Notificaciones
    @notifications_ns.route('/')
    class NotificacionList(Resource):
        @notifications_ns.doc('listar_notificaciones', security='Bearer Auth')
        def get(self):
            """Lista todas las notificaciones del usuario actual"""
            pass

    # Reportes
    @reports_ns.route('/ventas')
    class ReporteVentas(Resource):
        @reports_ns.doc('generar_reporte_ventas', security='Bearer Auth')
        def get(self):
            """Genera un reporte de ventas"""
            pass

    # Roles
    @roles_ns.route('/')
    class RolList(Resource):
        @roles_ns.doc('listar_roles', security='Bearer Auth')
        def get(self):
            """Lista todos los roles disponibles"""
            pass

    # Agregamos todos los namespaces al api de documentación
    api.add_namespace(users_ns)
    api.add_namespace(products_ns)
    api.add_namespace(reviews_ns)
    api.add_namespace(orders_ns)
    api.add_namespace(purchases_ns)
    api.add_namespace(categories_ns)
    api.add_namespace(carts_ns)
    api.add_namespace(inventory_ns)
    api.add_namespace(sizes_ns)
    api.add_namespace(genders_ns)
    api.add_namespace(stock_history_ns)
    api.add_namespace(notifications_ns)
    api.add_namespace(reports_ns)
    api.add_namespace(roles_ns)

    return app
