<?php


use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Laravel\Sanctum\PersonalAccessToken;

class TokenDeleted
{
    use Dispatchable;
    use SerializesModels;

    public $token;

    public function __construct(PersonalAccessToken $token)
    {
        $this->token = $token;
    }
}
