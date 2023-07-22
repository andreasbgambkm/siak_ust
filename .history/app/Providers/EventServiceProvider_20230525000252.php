<?php

namespace App\Providers;

use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Event;
use Laravel\Sanctum\PersonalAccessToken as SanctumPersonalAccessToken;
use Laravel\Sanctum\Events\TokenDeleted;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event to listener mappings for the application.
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
        TokenDeleted::class => [
            DeleteExpiredTokens::class,
        ],
    ];

    /**
     * Register any events for your application.
     */
    public function boot(): void
    {
        parent::boot();

        SanctumPersonalAccessToken::creating(function ($token) {
            $existingToken = PersonalAccessToken::where('tokenable_id', $token->tokenable_id)->first();

            if ($existingToken) {
                // Jika ada token yang sudah ada, update waktu kadaluarsa token yang sudah ada
                $existingToken->expires_at = now()->addMinutes(2); // Ubah jumlah menit sesuai kebutuhan Anda
                $existingToken->save();

                // Ubah token yang sedang dibuat menjadi null agar tidak menyimpan token baru
                return null;
            }

            $token->expires_at = now()->addMinutes(30); // Ubah jumlah menit sesuai kebutuhan Anda
        });

        SanctumPersonalAccessToken::deleting(function ($token) {
            event(new TokenDeleted($token));
        });
    }

    /**
     * Determine if events and listeners should be automatically discovered.
     */
    public function shouldDiscoverEvents(): bool
    {
        return false;
    }
}