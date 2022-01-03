// IDifferentiable.cs
// Copyright (C) 2022 Marquis Kurt <software@marquiskurt.net>
// This file is part of Indexing Your Heart.
//
// Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
// CNPLv7+ as found in the LICENSE file in the source code root directory or at 
// <https://git.pixie.town/thufie/npl-builder>.
//
// Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
// details.

namespace HeadOverHeels.Interfaces
{
    ///<summary> An interface that declares a class has values that change over time and can be described with a delta
    /// function that determines how to reach from state of a class to another. </summary>
    public interface IDifferentiable
    {
        /// <summary> Returns information that describes how to update a class to another version of a class. </summary>
        /// <param name="other"> The starting class that will use the delta to reach the current class's state. </param>
        object Delta(IDifferentiable other);
    }
}