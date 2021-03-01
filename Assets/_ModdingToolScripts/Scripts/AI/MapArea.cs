using System.Collections.Generic;
using AIProject.Animal;
using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class MapArea : MonoBehaviour
    {
        public enum AreaType
        {
            Normal,
            Indoor,
            Private
        }

        // load shits
        // addpoints
        [SerializeField] private AreaType _type;
        [SerializeField] private int _areaID;
        [SerializeField] private List<Waypoint> _waypoints = new List<Waypoint>();
        [SerializeField] private List<BasePoint> _basePoints = new List<BasePoint>();
        [SerializeField] private List<DevicePoint> _devicePoints = new List<DevicePoint>();
        [SerializeField] private List<FarmPoint> _farmPoints = new List<FarmPoint>();
        [SerializeField] private List<ShipPoint> _shipPoints = new List<ShipPoint>();
        [SerializeField] private List<ActionPoint> _actionPoints = new List<ActionPoint>();
        [SerializeField] private List<MerchantPoint> _merchantPoints = new List<MerchantPoint>();
        [SerializeField] private List<EventPoint> _eventPoints = new List<EventPoint>();
        [SerializeField] private List<StoryPoint> _storyPoints = new List<StoryPoint>();
        [SerializeField] private List<AnimalPoint> _animalPoints = new List<AnimalPoint>();
        [SerializeField] private List<ActionPoint> _appendActionPoints = new List<ActionPoint>();
        [SerializeField] private List<FarmPoint> _appendFarmPoints = new List<FarmPoint>();
        [SerializeField] private List<HPoint> _appendHPoints = new List<HPoint>();
        [SerializeField] private Collider[] _colliders;
        [SerializeField] private Collider[] _hColliders;
        private List<CraftPoint> _appendCraftPoints = new List<CraftPoint>();
        private List<JukePoint> _appendJukePoints = new List<JukePoint>();
        private List<LightSwitchPoint> _appendLightSwitchPoints = new List<LightSwitchPoint>();
        private List<PetHomePoint> _appendPetHomePoints = new List<PetHomePoint>();
    }
}