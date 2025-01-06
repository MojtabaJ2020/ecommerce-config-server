# Read Me First
The following was discovered as part of building this project:

* The original package name 'com.ecommerce.config-server' is invalid and this project uses 'com.ecommerce.config_server' instead.

# Getting Started

### Reference Documentation
For further reference, please consider the following sections:

* [Official Gradle documentation](https://docs.gradle.org)
* [Spring Boot Gradle Plugin Reference Guide](https://docs.spring.io/spring-boot/3.4.1/gradle-plugin)
* [Create an OCI image](https://docs.spring.io/spring-boot/3.4.1/gradle-plugin/packaging-oci-image.html)
* [Spring Boot DevTools](https://docs.spring.io/spring-boot/3.4.1/reference/using/devtools.html)
* [Config Server](https://docs.spring.io/spring-cloud-config/reference/server.html)

### Guides
The following guides illustrate how to use some features concretely:

* [Centralized Configuration](https://spring.io/guides/gs/centralized-configuration/)

### Additional Links
These additional references should also help you:

* [Gradle Build Scans – insights for your project's build](https://scans.gradle.com#gradle)

# How to generate jks file and use the config-server endpoint

- keytool -genkeypair -keyalg RSA -validity 9999  -keysize 2048 -keystore keystore.jks -alias spring -storepass password -keypass password
- http://localhost:8888/encrypt