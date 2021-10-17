using System;
using System.Collections.Generic;
using Katorin.Interfaces;

namespace Katorin.Utilities
{
    /// <summary> A class responsible for managing multiple states of an object, presumably as updates. </summary>
    /// <remarks> Objects stored in VersionControl must be versionable, so that they can be easily identified and
    /// described with a delta function that determines how to reach from one state to another. </remarks>
    /// <see cref="IVersionable"/>
    public class VersionControlService<T> where T : IVersionable
    {
        private readonly Stack<T> _commits = new Stack<T>();

        /// <summary> The number of commits in the commit history. </summary>
        public int Count { get => _commits.Count; }

        /// <summary> The latest commit in the commit history. </summary>
        public T LatestCommit { get => _commits.Peek(); }

        /// <summary> Commit the set of changes to the version control history. </summary>
        public void Commit(T changes) => _commits.Push(changes);

        /// <summary> Revert to a previous commit. </summary>
        /// <param name="commitCount"> The number of commits relative to the latest commit to roll back. </param>
        public void Revert(int commitCount)
        {
            var count = 0;
            while (count < commitCount)
            {
                _commits.Pop();
                count += 1;
            }
        }

        /// <summary> Revert to a previous commit. </summary>
        /// <param name="commitHash"> The ID of the commit to roll back to. </param>
        public void Revert(Guid commitHash)
        {
            while (LatestCommit.Id != commitHash)
                _commits.Pop();
        }

    }
}