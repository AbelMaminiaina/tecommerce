#!/bin/bash

# Create new Odoo module script
# Usage: ./scripts/create-module.sh module_name "Module Display Name"

MODULE_NAME=$1
MODULE_DISPLAY_NAME=$2

if [ -z "$MODULE_NAME" ]; then
    echo "Usage: ./scripts/create-module.sh module_name \"Module Display Name\""
    echo ""
    echo "Example: ./scripts/create-module.sh my_custom_module \"My Custom Module\""
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
MODULE_PATH="$PROJECT_ROOT/addons/$MODULE_NAME"

if [ -d "$MODULE_PATH" ]; then
    echo "Error: Module $MODULE_NAME already exists!"
    exit 1
fi

echo "Creating module: $MODULE_NAME"

# Create module structure
mkdir -p "$MODULE_PATH"/{models,views,security,data,static,controllers}

# Create __init__.py files
cat > "$MODULE_PATH/__init__.py" << EOF
# -*- coding: utf-8 -*-
from . import models
from . import controllers
EOF

cat > "$MODULE_PATH/models/__init__.py" << EOF
# -*- coding: utf-8 -*-
from . import ${MODULE_NAME}_model
EOF

cat > "$MODULE_PATH/controllers/__init__.py" << EOF
# -*- coding: utf-8 -*-
from . import ${MODULE_NAME}_controller
EOF

# Create __manifest__.py
cat > "$MODULE_PATH/__manifest__.py" << EOF
# -*- coding: utf-8 -*-
{
    'name': '${MODULE_DISPLAY_NAME:-$MODULE_NAME}',
    'version': '18.0.1.0.0',
    'category': 'Custom',
    'summary': '${MODULE_DISPLAY_NAME:-$MODULE_NAME}',
    'description': """
${MODULE_DISPLAY_NAME:-$MODULE_NAME}
=====================================
Custom module for Odoo 18
    """,
    'author': 'Your Company',
    'website': 'https://www.yourcompany.com',
    'license': 'LGPL-3',
    'depends': ['base'],
    'data': [
        'security/ir.model.access.csv',
        'views/${MODULE_NAME}_views.xml',
    ],
    'demo': [],
    'installable': True,
    'application': False,
    'auto_install': False,
}
EOF

# Create basic model
cat > "$MODULE_PATH/models/${MODULE_NAME}_model.py" << EOF
# -*- coding: utf-8 -*-
from odoo import models, fields, api

class $(echo ${MODULE_NAME} | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}' | sed 's/ //g')(models.Model):
    _name = '${MODULE_NAME}.${MODULE_NAME}'
    _description = '${MODULE_DISPLAY_NAME:-$MODULE_NAME}'

    name = fields.Char(string='Name', required=True)
    description = fields.Text(string='Description')
    active = fields.Boolean(string='Active', default=True)
    date = fields.Date(string='Date')
    user_id = fields.Many2one('res.users', string='Responsible', default=lambda self: self.env.user)
EOF

# Create basic view
cat > "$MODULE_PATH/views/${MODULE_NAME}_views.xml" << EOF
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Tree View -->
    <record id="${MODULE_NAME}_view_tree" model="ir.ui.view">
        <field name="name">${MODULE_NAME}.tree</field>
        <field name="model">${MODULE_NAME}.${MODULE_NAME}</field>
        <field name="arch" type="xml">
            <tree>
                <field name="name"/>
                <field name="date"/>
                <field name="user_id"/>
            </tree>
        </field>
    </record>

    <!-- Form View -->
    <record id="${MODULE_NAME}_view_form" model="ir.ui.view">
        <field name="name">${MODULE_NAME}.form</field>
        <field name="model">${MODULE_NAME}.${MODULE_NAME}</field>
        <field name="arch" type="xml">
            <form>
                <sheet>
                    <group>
                        <field name="name"/>
                        <field name="date"/>
                        <field name="user_id"/>
                        <field name="active"/>
                    </group>
                    <group>
                        <field name="description"/>
                    </group>
                </sheet>
            </form>
        </field>
    </record>

    <!-- Action -->
    <record id="${MODULE_NAME}_action" model="ir.actions.act_window">
        <field name="name">${MODULE_DISPLAY_NAME:-$MODULE_NAME}</field>
        <field name="res_model">${MODULE_NAME}.${MODULE_NAME}</field>
        <field name="view_mode">tree,form</field>
    </record>

    <!-- Menu -->
    <menuitem id="${MODULE_NAME}_menu_root"
              name="${MODULE_DISPLAY_NAME:-$MODULE_NAME}"
              sequence="10"/>

    <menuitem id="${MODULE_NAME}_menu"
              name="${MODULE_DISPLAY_NAME:-$MODULE_NAME}"
              parent="${MODULE_NAME}_menu_root"
              action="${MODULE_NAME}_action"
              sequence="10"/>
</odoo>
EOF

# Create security file
cat > "$MODULE_PATH/security/ir.model.access.csv" << EOF
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
access_${MODULE_NAME}_user,${MODULE_NAME}.user,model_${MODULE_NAME}_${MODULE_NAME},base.group_user,1,1,1,1
EOF

# Create controller
cat > "$MODULE_PATH/controllers/${MODULE_NAME}_controller.py" << EOF
# -*- coding: utf-8 -*-
from odoo import http
from odoo.http import request

class $(echo ${MODULE_NAME} | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}' | sed 's/ //g')Controller(http.Controller):

    @http.route('/${MODULE_NAME}/', auth='public', website=True)
    def index(self, **kw):
        return request.render('${MODULE_NAME}.index', {})
EOF

# Create README
cat > "$MODULE_PATH/README.md" << EOF
# ${MODULE_DISPLAY_NAME:-$MODULE_NAME}

## Description
${MODULE_DISPLAY_NAME:-$MODULE_NAME} module for Odoo 18

## Features
- Basic CRUD operations
- User assignment
- Date tracking

## Installation
1. Copy this module to your Odoo addons directory
2. Restart Odoo
3. Update the app list
4. Install the module from Apps menu

## Usage
Access the module from the main menu: ${MODULE_DISPLAY_NAME:-$MODULE_NAME}

## Author
Your Company

## License
LGPL-3
EOF

echo ""
echo "Module $MODULE_NAME created successfully at: $MODULE_PATH"
echo ""
echo "Next steps:"
echo "1. Restart Odoo: docker-compose --profile dev restart odoo-dev"
echo "2. Update app list in Odoo (Apps > Update Apps List)"
echo "3. Install your module from the Apps menu"
echo ""
