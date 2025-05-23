"""Creamos id talla en compra_producto

Revision ID: ad729ab5fe2a
Revises: 845fafc28d0a
Create Date: 2025-05-15 11:31:15.243888

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'ad729ab5fe2a'
down_revision = '845fafc28d0a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('compra_producto', schema=None) as batch_op:
        batch_op.add_column(sa.Column('id_talla', sa.Integer(), nullable=True))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('compra_producto', schema=None) as batch_op:
        batch_op.drop_column('id_talla')

    # ### end Alembic commands ###
