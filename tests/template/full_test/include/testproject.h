#ifndef TESTPROJECT_H
#define TESTPROJECT_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Get a greeting message
 * @return Pointer to greeting string
 */
const char* testproject_get_greeting(void);

/**
 * @brief Get version string
 * @return Pointer to version string
 */
const char* testproject_get_version(void);

#ifdef __cplusplus
}
#endif

#endif // TESTPROJECT_H 