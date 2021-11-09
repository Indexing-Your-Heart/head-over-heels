// NodeExtensions.cs
// Copyright (C) 2021 Marquis Kurt <software@marquiskurt.net>
// This file is part of Indexing Your Heart.
//
// Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
// CNPLv7+ as found in the LICENSE file in the source code root directory or at 
// <https://git.pixie.town/thufie/npl-builder>.
//
// Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
// details.

using System;
using Godot;

namespace HeadOverHeels.Extensions
{
    public static class NodeExtensions
    {
        /// <summary> Returns an array of references to the node's children, with a given predicate. </summary>
        /// <param name="node"> The node to grab the children of. </param>
        /// <param name="predicate"> A function that defines what children should be kept. </param>
        public static Godot.Collections.Array GetChildren(this Node node, Func<Node, bool> predicate)
        {
            var children = node.GetChildren();
            foreach (Node child in children)
            {
                if (!predicate(child))
                    children.Remove(child);
            }
            return children;
        }
    }
}