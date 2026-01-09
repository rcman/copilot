// kernel_util.cpp - tiny C++ helper (no exceptions, no RTTI).
// Provide extern "C" wrappers to call from C.
// Keep this minimal: avoid STL, dynamic allocation.

extern "C" void cpp_log(const char* msg);

extern "C" void cpp_log(const char* msg) {
    // Minimal console write: in a real kernel you'd write to serial I/O port.
    // For now, we provide a placeholder that could map to a memory-mapped console
    // or to a SIMH console via a special trap. We'll just implement a no-op.
    (void)msg;
}
