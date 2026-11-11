<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        $admins = [
            [
                'name' => 'César Velandia',
                'email' => 'cesar.velandia@wppmedia.com',
            ],
            [
                'name' => 'Rubén Torres',
                'email' => 'ruben.torres@wppmedia.com',
            ],
            [
                'name' => 'John Penagos',
                'email' => 'john.penagos@wppmedia.com',
            ],
        ];

        foreach ($admins as $adminData) {
            User::updateOrCreate(
                ['email' => $adminData['email']],
                [
                    'name' => $adminData['name'],
                    'role' => 'admin',
                    'password' => null,
                ]
            );
        }
    }
}
