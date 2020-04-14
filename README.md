# into-docker-clojure-graalvm

[![](https://images.microbadger.com/badges/version/intodocker/clojure-graalvm.svg)](https://hub.docker.com/r/intodocker/clojure-graalvm)
[![](https://images.microbadger.com/badges/image/intodocker/clojure-graalvm.svg)](https://hub.docker.com/r/intodocker/clojure-graalvm)

This is an [into-docker][into] builder image for Clojure applications relying on
[Leiningen][lein] and including a GraalVM [native-image][] build step.

[into]: https://github.com/into-docker/into-docker
[lein]: https://leiningen.org/
[native-image]: https://www.graalvm.org/docs/reference-manual/native-image/

## Usage

Run the following in the root directory of your Clojure project:

```sh
into -t <repository>:<tag> intodocker/clojure-graalvm .
```

Please make sure that your Uberjar contains all necessary configuration files at
`META-INF/native-image/<groupId>/<artifactId>` as described
[here][native-image-configuration].

[native-image-configuration]: https://www.graalvm.org/docs/reference-manual/native-image/#native-image-configuration

## Notes

Make sure your project's `uberjar` task creates its output at
`target/*-standalone.jar` since this is where the builder image will expect it.

## License

```
MIT License

Copyright (c) 2020 Yannick Scherer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
