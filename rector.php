<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\TypeDeclaration\Rector\StmtsAwareInterface\DeclareStrictTypesRector;
use RectorLaravel\Set\LaravelSetList;

return RectorConfig::configure()
    ->withPaths([
        __DIR__.'/app',
        __DIR__.'/config',
        __DIR__.'/database',
        __DIR__.'/routes',
        __DIR__.'/tests',
    ])
    ->withImportNames()
    ->withPhpSets(php84: true)
    ->withSets([
        LaravelSetList::LARAVEL_100,
    ])
    ->withRules([
        DeclareStrictTypesRector::class,
    ])
    ->withTypeCoverageLevel(5);
