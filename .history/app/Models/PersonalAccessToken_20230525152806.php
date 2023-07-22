<?php

namespace App\Models;

use Laravel\Sanctum\PersonalAccessToken as SanctumPersonalAccessToken;

class PersonalAccessToken extends SanctumPersonalAccessToken
{
    protected $table = 'personal_access_tokens';
    protected $primaryKey = 'tokenable_id';
    protected $casts = [
        'last_used_at' => 'datetime',
    ];

}
