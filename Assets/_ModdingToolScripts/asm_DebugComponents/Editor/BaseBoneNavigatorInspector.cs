#if UNITY_EDITOR
using System.Collections.Generic;
using System.Linq;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents.Inspectors
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(BoneNavigator))]
    public class BoneNavigatorInspector : NiceInspector
    {
        private string _previousWord;
        private Vector2 _scrollPos;
        private Dictionary<string, string> _searchResult = new Dictionary<string, string>();
        private string _searchWord;

        protected override void DrawInspectorGUI()
        {
            var navigatorComponent = GetTarget<BoneNavigator>();

            EditorGUI.indentLevel = 1;
            GUILayout.BeginVertical("box");

            _searchWord = GUILayout.TextField(_searchWord);
            if (_previousWord != _searchWord)
            {
                _searchResult = BoneNavigator.AccessoryPoints
                    .Where(x => x.Value.ToLower().Contains(_searchWord))
                    .ToDictionary(
                        x => x.Key
                        , x => x.Value
                    );
            }
            else if (_searchResult.Count > 0 && _searchWord.IsNullOrEmpty())
            {
                _searchResult.Clear();
            }

            _previousWord = _searchWord;

            _scrollPos = GUILayout.BeginScrollView(_scrollPos, "box", GUILayout.Height(200));
            var validSearch = !_searchWord.IsNullOrEmpty();
            var resultCount = _searchResult.Count;
            if (validSearch && resultCount <= 0)
            {
                GUILayout.Label("No result. Try other words.");
            }
            else
            {
                foreach (var objectName in from pairs in validSearch ? _searchResult : BoneNavigator.AccessoryPoints
                    let name = pairs.Value
                    let objectName = pairs.Key
                    where GUILayout.Button(name, EditorStyles.toolbarButton)
                    select objectName)
                {
                    Run(() => { navigatorComponent.NavigateToBone(objectName); });
                }
            }

            GUILayout.EndScrollView();

            EditorGUI.indentLevel = 0;
            GUILayout.EndVertical();
        }

        protected override void InitializeProperties()
        {
        }
    }
}
#endif