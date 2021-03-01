using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public abstract class EventConsumer : MonoBehaviour
{
    public enum EventType
    {
        Common,
        Nomi
    }

    private static readonly HashSet<EventConsumer> EventConsumers = new HashSet<EventConsumer>();

    public EventType type = EventType.Common;
    
    public static void EmitEvent(EventType eventType)
    {
        foreach (var eventConsumer in EventConsumers.Where(eventConsumer => eventConsumer.type == eventType))
        {
            eventConsumer.DoEvent();
        }
    }
    
    internal abstract void DoEvent(); 
    
    private void Start()
    {
        EventConsumers.Add(this);
    }

    private void OnEnable()
    {
        EventConsumers.Add(this);
    }

    private void OnDisable()
    {
        EventConsumers.Remove(this);
    }

    private void OnDestroy()
    {
        EventConsumers.Remove(this);
    }
}