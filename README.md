# Cursor ID Reset Tool

A simple tool to reset identification values in Cursor Editor when you encounter the "Too many free trial accounts" error message.

## What This Tool Does

- Generates new random IDs for your Cursor Editor
- Updates the necessary files automatically
- Works on Windows, Linux, and macOS

## Quick Start Guide

### On Windows
1. Close Cursor Editor
2. Download `reset_cursor_id_windows.bat`
3. Right-click and "Run as Administrator"

### On Linux/macOS
1. Close Cursor Editor
2. Download `reset_cursor_id_unix.sh`
3. Open terminal and run:
```bash
chmod +x reset_cursor_id_unix.sh
./reset_cursor_id_unix.sh
```

## Where Are The Files Located?

The tool will automatically find and update the file at:
- Windows: `%APPDATA%\Cursor\User\globalStorage\storage.json`
- Linux/macOS: `~/.config/Cursor/User/globalStorage/storage.json`

## Common Issues

1. **Script won't run?**
   - Make sure Cursor Editor is closed
   - On Windows: Run as administrator
   - On Linux/macOS: Make sure you gave execute permission

2. **Still seeing the error?**
   - Restart Cursor Editor after running the script
   - Make sure the file location is correct

## Important Notes

- Always close Cursor Editor before running this tool
- The tool creates a backup of your files automatically
- This is for troubleshooting purposes only
- Consider purchasing a license if you use Cursor Editor regularly

## Need Help?

If you're having problems:
1. Make sure you followed the steps exactly
2. Check if the files exist in the correct location
3. Verify you have proper permissions

## Legal Note

This tool is for troubleshooting purposes only. Please respect Cursor Editor's terms of service and consider purchasing a license to support the developers.