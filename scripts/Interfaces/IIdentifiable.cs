using System;

namespace Katorin.Interfaces
{
    /// <summary> An interface that indicates a class has a stable identity with a researchable identifier. </summary>
    /// <remarks> This interface is inspired by the Identifiable protocol in Swift:
    /// https://developer.apple.com/documentation/swift/identifiable . </remarks>
    public interface IIdentifiable
    {
        /// <summary>The globally-unique identifier for the class.</summary>
        Guid Id { get; set; }

    }
}