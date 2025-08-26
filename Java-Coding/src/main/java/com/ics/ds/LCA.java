package com.ics.ds;

public class LCA {
    public static TreeNode findLCA(TreeNode root, TreeNode p, TreeNode q){
        if(root ==null) return null;
        if(p.val<root.val && q.val<root.val)
            return findLCA(root.left,p,q);
        else if(p.val>root.val && q.val>root.val)
            return findLCA(root.right,p,q);
        else return root;
    }

}



class TreeNode {
    int val;
    TreeNode left, right;

    TreeNode(int x) {
        val = x;
    }
}
