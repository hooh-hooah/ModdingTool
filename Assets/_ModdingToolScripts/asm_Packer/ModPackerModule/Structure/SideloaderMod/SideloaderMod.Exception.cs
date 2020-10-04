using System;

namespace ModPackerModule.Structure.SideloaderMod
{
    public class InvalidBundleTargetException : Exception
    {
        public InvalidBundleTargetException()
        {
        }

        public InvalidBundleTargetException(string message)
            : base(message)
        {
        }

        public InvalidBundleTargetException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }

    public class InvalidListTargetException : Exception
    {
        public InvalidListTargetException()
        {
        }

        public InvalidListTargetException(string message)
            : base(message)
        {
        }

        public InvalidListTargetException(string message, Exception inner)
            : base(message, inner)
        {
        }
    }
}