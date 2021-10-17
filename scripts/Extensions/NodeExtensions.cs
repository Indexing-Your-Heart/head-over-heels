using System;
using Godot;

namespace Katorin.Extensions
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