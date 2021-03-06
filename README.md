# macOS Mail Signature Installer

Easily install HTML signatures in macOS’s Mail application.

## Usage

Pipe your signature file into `install-signature.sh` and pass the desired name of your signature as the first argument, for example:

```sh
$ cat my-signature.html | ./install-signature.sh "My Signature"
```

## Acknowledgments

Thanks to [@coneybeare](https://github.com/coneybeare) for [his tutorial on making an HTML signature in Apple Mail](http://matt.coneybeare.me/how-to-make-an-html-signature-in-apple-mail-for-high-sierra-os-x-10-dot-13/).

## License

`macos-mail-signature-installer` is licensed under the BSD 2-clause license. See [LICENSE](./LICENSE) for the full license.
