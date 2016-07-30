#!/usr/bin/env bash
set -euo pipefail

signatureUniqueId="$(uuidgen)"
signaturesDirectory="$HOME/Library/Mobile Documents/com~apple~Mail/Data/MailData/Signatures"
allSignaturesPlist="$signaturesDirectory/ubiquitous_AllSignatures.plist"
mailsignatureFile="$signaturesDirectory/ubiquitous_$signatureUniqueId.mailsignature"

# Not using iCloud Drive.
if [ ! -f "$signaturesDirectory/ubiquitous_AllSignatures.plist" ]; then
	signaturesDirectory="$HOME/Library/Mail/V2/MailData/Signatures"
	allSignaturesPlist="$signaturesDirectory/AllSignatures.plist"
	mailsignatureFile="$signaturesDirectory/$signatureUniqueId.mailsignature"
fi

if [ ! -f "$allSignaturesPlist" ]; then
	>&2 echo "Could not find $allSignaturesPlist."
	exit 1
fi

if [ -t 0 ]; then
	>&2 echo "stdin seems to be empty."
	exit 1
fi

if [ -z "${1:-}" ]; then
	>&2 echo "No signature name passed."
	exit 1
fi

/usr/libexec/PlistBuddy -c "Add :0 dict" "$allSignaturesPlist"
/usr/libexec/PlistBuddy -c "Add :0:SignatureIsRich bool true" "$allSignaturesPlist"
/usr/libexec/PlistBuddy -c "Add :0:SignatureName string '$1'" "$allSignaturesPlist"
/usr/libexec/PlistBuddy -c "Add :0:SignatureUniqueId string '$signatureUniqueId'" "$allSignaturesPlist"

cat <<EOF > "$mailsignatureFile"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8
Message-Id: <$(uuidgen)>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))

EOF

cat | perl -MMIME::QuotedPrint -pe '$_=MIME::QuotedPrint::encode($_)' >> "$mailsignatureFile"

echo "Installed “$1” signature with ID $signatureUniqueId."
