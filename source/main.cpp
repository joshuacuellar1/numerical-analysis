/*
Copyright (c) 2025, Joshua Cuellar.
*/


#include <exception>
#include <string>

#include <CLI/CLI.hpp>
#include <fmt/base.h>


auto main(int argc, const char *argv[]) -> int {
    try {
        auto app = CLI::App("Numerical Analysis", "numerical_analysis");
        std::string message;
        app.add_option("-m,--message", message, "Print a message")
                ->default_val("Hello World!");
        try {
            (app).parse(argc, argv);
        } catch (const CLI::ParseError &e) {
            return (app).exit(e);
        }
        // print_message(message);
        fmt::print("{}\n", message);
        return 0;
    } catch (const std::exception &e) {
        fmt::print(stderr, "Unhandled exception: {}\n", e.what());
        return 1;
    } catch (...) {
        fmt::print(stderr, "Unknown exception\n");
        return 2;
    }
}
