<?php

namespace App\Models;

use Laravel\Sanctum\PersonalAccessToken as SanctumPersonalAccessToken;

class PersonalAccessToken extends SanctumPersonalAccessToken
{
    protected $table = 'personal_access_tokens';

    protected $casts = [
        'last_used_at' => 'datetime',
    ];
    public static function createToken($name, $abilities = ['*'])
    {
        $user = auth('sanctum')->user()->id;

        return $user->createToken($name, $abilities);
    }
}
