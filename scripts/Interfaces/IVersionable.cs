// IVersionable.cs
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
    ///<summary> A super-interface that declares a class is uniquely identifiable (i.e., has a stable identity) and has
    /// a means to differentiate itself between other classes, described with a delta function. </summary>
    public interface IVersionable : IIdentifiable, IDifferentiable
    {

    }
}