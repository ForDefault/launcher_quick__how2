#!/bin/bash
##run as sudo
# Step 1: Create a custom script for Codium
echo "Creating custom Codium launcher..."
cat > /usr/local/bin/custom_codium << 'EOF'
#!/bin/bash
env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/codium_codium.desktop /snap/bin/codium --force-user-env "$@"
EOF

# Make the script executable
chmod +x /usr/local/bin/custom_codium
echo "Custom launcher created at /usr/local/bin/custom_codium"

# Step 2: Create a .desktop entry for Codium
echo "Creating .desktop entry for custom Codium..."
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/custom_codium.desktop << 'EOF'
[Desktop Entry]
Name=Custom Codium
Exec=/usr/local/bin/custom_codium %F
Terminal=false
Type=Application
Icon=com.vscodium.codium
MimeType=text/plain;application/x-shellscript;
Categories=Development;TextEditor;
EOF

# Update the desktop database
update-desktop-database ~/.local/share/applications
echo "Custom .desktop entry created at ~/.local/share/applications/custom_codium.desktop"

# Step 3: Update MIME associations
echo "Updating MIME associations..."
cat >> ~/.config/mimeapps.list << 'EOF'
text/plain=custom_codium.desktop
application/x-shellscript=custom_codium.desktop
EOF

echo "MIME associations updated."

# Step 4: Confirmation
echo "Setup complete! Custom Codium launcher is ready."
echo "To test, open a text file or run 'custom_codium <filename>'."
