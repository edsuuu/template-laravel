<div class="flex flex-col gap-6">
    <div class="flex w-full flex-col text-center">
        <flux:heading size="xl">{{ __('Reset password') }}</flux:heading>
        <flux:subheading>{{ __('Enter your new password below') }}</flux:subheading>
    </div>

    <form method="POST" action="{{ route('password.update') }}" class="flex flex-col gap-6">
        @csrf

        <input type="hidden" name="token" value="{{ $token }}">

        <!-- Email Address -->
        <flux:input
            name="email"
            :label="__('Email address')"
            :value="old('email', $email)"
            type="email"
            required
            readonly
            autocomplete="email"
        />

        <!-- Password -->
        <flux:input
            name="password"
            :label="__('Password')"
            type="password"
            required
            autofocus
            autocomplete="new-password"
            :placeholder="__('Password')"
            viewable
        />

        <!-- Confirm Password -->
        <flux:input
            name="password_confirmation"
            :label="__('Confirm password')"
            type="password"
            required
            autocomplete="new-password"
            :placeholder="__('Confirm password')"
            viewable
        />

        <div class="flex items-center justify-end">
            <flux:button variant="primary" type="submit" class="w-full">
                {{ __('Reset password') }}
            </flux:button>
        </div>
    </form>
</div>
