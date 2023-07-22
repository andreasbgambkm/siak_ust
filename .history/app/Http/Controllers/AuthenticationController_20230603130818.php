<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\PersonalAccessToken;
use Illuminate\Support\Str;
use App\Traits\HttpResponses;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

use Illuminate\Support\Facades\Log;

class AuthenticationController extends Controller
{
    use HttpResponses;
    public function login(Request $request)
    {
        $validatedData =  $request->validate([
            'id'=>'required',
            'password'=>'required'
        ]);

        $user=User::where('id', $request->id)->first();
        if (!$user || md5($validatedData['password']) !== $user->password) {
            return $this->error('', 'Credentials do not match', 401);
        }
        if (!$user || md5($validatedData['password']) !== $user->password) {
            return $this->error('', 'Credentials do not match', 401);
        }

        if ($user->level !== 3) {
            return $this->error('', 'Access denied', 403);
        }
        $user->ip_log = $request->ip();
        $user->com_name = gethostbyaddr($request->ip());
        $user->ip= $request->ip();

        $user->webu= $request->header('User-Agent');

        $user->login_terakhir = date('Y-m-d H:i:s');
        $user->save();


        $personalAccessToken = PersonalAccessToken::where('tokenable_id', $user->id)
            ->first();

        if ($personalAccessToken) {
            $personalAccessToken->delete();
            $personalAccessToken = $user->createToken($request->userAgent(), []);

        } else {
            $personalAccessToken = $user->createToken($request->userAgent(), []);
        }

        return response()->json([
            'token' => $personalAccessToken->plainTextToken
        ]);
    }
    public function logout(Request $request)
    {
        $user = $request->user();

        // Menghapus token Sanctum yang terkait dengan user saat ini
        $user->tokens()->delete();

        return response()->json([
            'message' => 'Logout berhasil'
        ]);
    }


}
