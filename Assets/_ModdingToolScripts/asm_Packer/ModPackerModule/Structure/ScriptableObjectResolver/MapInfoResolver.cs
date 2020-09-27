using JetBrains.Annotations;
using UnityEngine;

namespace ModPackerModule.Structure.ScriptableObjectResolver
{
    public class MapInfoResolver : ResolverBase<ScriptableObject>
    {
        public MapInfoResolver([NotNull] ScriptableObject instance) : base(ref instance)
        {
        }

        protected override string GetTypeName => "MapInfo";
    }
}