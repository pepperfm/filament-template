<?php

declare(strict_types=1);

namespace App\Exceptions;

class EntityNotFoundException extends EntityException
{
    public function __construct(string $message = '')
    {
        parent::__construct(\Illuminate\Http\JsonResponse::HTTP_NOT_FOUND, $message);
    }
}
