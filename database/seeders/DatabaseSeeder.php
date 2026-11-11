<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $admins = [
            [
                'name' => 'César Velandia',
                'email' => 'cesar.velandia@wppmedia.com',
                'role' => 'admin',
                'status' => 'active',
                'markets' => null,
            ],
            [
                'name' => 'Rubén Torres',
                'email' => 'ruben.torres@wppmedia.com',
                'role' => 'admin',
                'status' => 'active',
                'markets' => null,
            ],
            [
                'name' => 'John Penagos',
                'email' => 'john.penagos@wppmedia.com',
                'role' => 'admin',
                'status' => 'active',
                'markets' => null,
            ],
        ];

        foreach ($admins as $adminData) {
            User::firstOrCreate(
                ['email' => $adminData['email']],
                [
                    'name' => $adminData['name'],
                    'role' => $adminData['role'],
                    'status' => $adminData['status'],
                    'markets' => $adminData['markets'],
                    'login_token' => Str::random(32),
                ]
            );
        }
    }
}
