<?php
return [
    'backend' => [
        'frontName' => 'admin_l1nqxk'
    ],
    'db' => [
        'connection' => [
            'indexer' => [
                'host' => '!HOST!',
                'dbname' => '!DBNAME!',
                'username' => '!DBUSER!',
                'password' => '!DBPASS!',
                'model' => 'mysql4',
                'engine' => 'innodb',
                'initStatements' => 'SET NAMES utf8;',
                'active' => '1',
                'persistent' => NULL
            ],
            'default' => [
                'host' => '!HOST!',
                'dbname' => '!DBNAME!',
                'username' => '!DBUSER!',
                'password' => '!DBPASS!',
                'model' => 'mysql4',
                'engine' => 'innodb',
                'initStatements' => 'SET NAMES utf8;',
                'active' => '1'
            ]
        ],
        'table_prefix' => ''
    ],
    'crypt' => [
        'key' => 'cc320d9df46c7933341a6503f694e6fb'
    ],
    'resource' => [
        'default_setup' => [
            'connection' => 'default'
        ]
    ],
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => '!MAGEMODE!',
    'session' => [
        'save' => 'redis',
        'redis' => [
            'host' => '!REDISHOST!',
            'port' => '6379',
            'password' => '',
            'timeout' => '10',
            'persistent_identifier' => '',
            'database' => '2',
            'compression_threshold' => '2048',
            'compression_library' => 'gzip',
            'log_level' => '3',
            'max_concurrency' => '6',
            'break_after_frontend' => '5',
            'break_after_adminhtml' => '30',
            'first_lifetime' => '600',
            'bot_first_lifetime' => '60',
            'bot_lifetime' => '7200',
            'disable_locking' => '0',
            'min_lifetime' => '60',
            'max_lifetime' => '2592000'
        ]
    ],
    'cache_types' => [
        'config' => 1,
        'layout' => 1,
        'block_html' => 1,
        'collections' => 1,
        'reflection' => 1,
        'db_ddl' => 1,
        'compiled_config' => 1,
        'eav' => 1,
        'customer_notification' => 1,
        'config_integration' => 1,
        'config_integration_api' => 1,
        'target_rule' => 1,
        'full_page' => 1,
        'config_webservice' => 1,
        'translate' => 1,
        'vertex' => 1
    ],
    'install' => [
        'date' => 'Fri, 07 Dec 2018 05:17:38 +0000'
    ],
    'system' => [
        'default' => [
            'dev' => [
                'debug' => [
                    'debug_logging' => '0'
                ]
            ]
        ]
    ],
    'cache' => [
        'frontend' => [
            'default' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'server' => '!REDISHOST!',
                    'database' => '0',
                    'port' => '6379',
                    'password' => ''
                ]
            ],
            'page_cache' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'server' => '!REDISHOST!',
                    'database' => '1',
                    'port' => '6379',
                    'compress_data' => '0',
                    'password' => ''
                ]
            ]
        ]
    ]
];
