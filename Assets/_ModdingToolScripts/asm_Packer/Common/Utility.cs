using System;
using System.Reflection;
using System.Text.RegularExpressions;
using UnityEngine;

namespace Common
{
    public class Utility
    {
        private static readonly Regex badPathName = new Regex("[\\\\/:*?\\\"<>|]");

        public static string GetProjectPath()
        {
            try
            {
                var projectBrowserType = Type.GetType("UnityEditor.ProjectBrowser,UnityEditor");
                var projectBrowser = projectBrowserType?.GetField("s_LastInteractedProjectBrowser", BindingFlags.Static | BindingFlags.Public)?.GetValue(null);
                var invokeMethod = projectBrowserType?.GetMethod("GetActiveFolderPath", BindingFlags.NonPublic | BindingFlags.Instance);
                return (string) invokeMethod?.Invoke(projectBrowser, new object[] { });
            }
            catch (Exception exception)
            {
                Debug.LogWarning("Error while trying to get current project path.");
                Debug.LogWarning(exception.Message);
                return string.Empty;
            }
        }

        public static string EscapePath(string path)
        {
            return badPathName.Replace(path, "");
        }
    }
}