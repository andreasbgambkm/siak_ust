<?php

use Laravel\Sanctum\PersonalAccessToken;

class DeleteExpiredTokens
{
    public function handle(TokenDeleted $event)
    {
        $token = $event->token;

        if ($token->expires_at && $token->expires_at->isPast()) {
            $token->delete();
        }
    }
}
