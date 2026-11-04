/* Uses a function from each of tfpsacrypto, mbedx509, and mbedtls, and data
 * from mbedx509 and mbedtls (which must be imported from the DLLs on Windows) */
#include <stdio.h>
#include <mbedtls/ssl.h>
#include <mbedtls/version.h>
#include <mbedtls/x509_crt.h>
#include <psa/crypto.h>

int main(void) {
    mbedtls_ssl_context ssl;
    mbedtls_x509_crt crt;

    printf("Mbed TLS %s\n", mbedtls_version_get_string());

    mbedtls_x509_crt_init(&crt);
    mbedtls_x509_crt_free(&crt);
    mbedtls_ssl_init(&ssl);
    mbedtls_ssl_free(&ssl);

    if (mbedtls_x509_crt_profile_default.rsa_min_bitlen < 2048) {
        return 1;
    }
#if defined(MBEDTLS_DEBUG_C)
    if (mbedtls_ssl_iana_tls_group_info[0].tls_id == 0) {
        return 1;
    }
#endif

    return psa_crypto_init() == PSA_SUCCESS ? 0 : 1;
}
