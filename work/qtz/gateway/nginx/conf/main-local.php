<?php

$config = [
    'components' => [
        'cache' => [
            'class' => 'yii\redis\Connection',
            'hostname' => '10.100.100.70',
            'port' => 7700,
            'database' => 0
        ],
        'log' => [
            'targets' => [
                [
                    'class' => 'sctek\yii\rpc\FileTarget',
                    'logFile' => '@app/runtime/logs/datacenter/datacenter.log',
                    'levels' => ['info'],
                    'categories' => ['datacenter'],
                ],
                [
                    'class' => 'sctek\yii\rpc\FileTarget',
                    'logFile' => '@app/runtime/logs/trace/trace.log',
                    'levels' => ['info'],
                    'categories' => ['Trace'],
                ],
                [
                    'class' => 'sctek\yii\rpc\FileTarget',
                    'logFile' => '@app/runtime/logs/error/error.log',
                    'levels' => ['error'],
                ],
                [
                    'class' => 'sctek\yii\rpc\FileTarget',
                    'logFile' => '@app/runtime/logs/info/info.log',
                    'levels' => ['info'],
                    'except' => ['Trace', 'datacenter']
                ],
            ]
        ],
    ],
];

return $config;
