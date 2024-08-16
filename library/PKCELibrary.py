import base64
import os
import hashlib

class PKCELibrary:
    
    def generate_code_verifier(self, length=128):
        characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~'
        random_bytes = os.urandom(length)
        code_verifier = ''.join(characters[b % len(characters)] for b in random_bytes)
        return code_verifier

    def sha256(self, plain):
        return hashlib.sha256(plain.encode('utf-8')).digest()

    def base64url_encode(self, b):
        return base64.urlsafe_b64encode(b).rstrip(b'=').decode('utf-8')

    def generate_code_challenge(self, code_verifier):
        hashed = self.sha256(code_verifier)
        return self.base64url_encode(hashed)
