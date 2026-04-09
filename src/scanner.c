#include "tree_sitter/parser.h"

#include <stdbool.h>
#include <stdint.h>

enum TokenType {
    L,
    CLASS_IDENTIFIER,
    ERROR_SENTINEL, // unused token for error recovery detection
};

void *tree_sitter_smali_external_scanner_create(void) { return NULL; }

void tree_sitter_smali_external_scanner_destroy(void *payload) { (void)payload; }

unsigned tree_sitter_smali_external_scanner_serialize(void *payload, char *buffer) {
    (void)payload;
    (void)buffer;
    return 0;
}

void tree_sitter_smali_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
    (void)payload;
    (void)buffer;
    (void)length;
}

static inline void advance(TSLexer *lexer) { lexer->advance(lexer, false); }

static inline void skip_whitespace(TSLexer *lexer) { lexer->advance(lexer, true); }

/// Check if a codepoint is a valid class identifier character.
/// Allows ASCII alphanumerics, '_', '-', '$', and any codepoint >= 0x80
/// (full Unicode support for obfuscated / non-ASCII identifiers).
static inline bool is_class_identifier_char(int32_t c) {
    if (c >= 0x80) return true;  // all non-ASCII Unicode
    if (c >= 'a' && c <= 'z') return true;
    if (c >= 'A' && c <= 'Z') return true;
    if (c >= '0' && c <= '9') return true;
    return c == '_' || c == '-' || c == '$';
}

static inline bool is_whitespace(int32_t c) {
    return c == ' ' || c == '\t' || c == '\n' || c == '\r' || c == '\f' || c == '\v';
}

bool tree_sitter_smali_external_scanner_scan(
    void *payload,
    TSLexer *lexer,
    const bool *valid_symbols
) {
    (void)payload;

    // If the error sentinel is valid, tree-sitter is in error recovery mode.
    // We can't help recover, so bail out immediately.
    if (valid_symbols[ERROR_SENTINEL]) {
        return false;
    }

    if (valid_symbols[L]) {
        while (is_whitespace(lexer->lookahead)) {
            skip_whitespace(lexer);
        }

        if (lexer->lookahead == 'L') {
            lexer->result_symbol = L;
            advance(lexer);
            lexer->mark_end(lexer);
            return true;
        }
    }

    if (valid_symbols[CLASS_IDENTIFIER]) {
        lexer->result_symbol = CLASS_IDENTIFIER;
        bool has_content = false;

        while (is_class_identifier_char(lexer->lookahead)) {
            has_content = true;
            advance(lexer);
        }

        if (has_content) {
            lexer->mark_end(lexer);
            return true;
        }
    }

    return false;
}
