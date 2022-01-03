// IIdentifiable.cs
// Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net>
// This file is part of Indexing Your Heart.
//
// Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
// CNPLv7+ as found in the LICENSE file in the source code root directory or at 
// <https://git.pixie.town/thufie/npl-builder>.
//
// Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
// details.

using System;

namespace HeadOverHeels.Interfaces
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