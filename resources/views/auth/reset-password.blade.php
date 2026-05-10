<x-layout :title="__('Reset password')">
    <livewire:auth.reset-password :token="request()->route('token')" :email="request()->string('email')" />
</x-layout>
